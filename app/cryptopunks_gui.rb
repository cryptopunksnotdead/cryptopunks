require 'glimmer-dsl-tk'
require 'cryptopunks'
require 'facets'
require 'fileutils'
require 'net/http'
require 'uri'
require 'glimmer/data_binding/observer'
require 'yaml'
require 'puts_debuggerer'

class CryptopunksGui
  include Glimmer
  
  PALETTES = ['Standard'] + (Palette8bit.constants).map(&:name).map {|palette| palette.split('_').map(&:capitalize).join(' ')}.reject { |palette| palette.include?(' ') }.sort
  STYLES = ['Normal', 'Led', 'Sketch']
  COLLECTIONS_YAML_URL = 'https://raw.githubusercontent.com/AndyObtiva/cryptopunks-gui/master/cryptopunks-collections.yml'
  COLLECTIONS_YAML_PATH = File.expand_path('../cryptopunks-collections.yml', __dir__)
  OUTPUT_LOCATION_DEFAULT = File.join(Dir.home, 'cryptopunks')
  
  attr_accessor :collection, :image_index, :zoom, :palette, :style, :led_spacing, :led_round_corner, :sketch_line, :flip, :mirror
  
  def initialize
    initialize_punk_directory
    initialize_collections_map
    initialize_collection
    load_config
    initialize_defaults
    observe_image_attribute_changes
    create_gui
    self.image_index = 0
    @root.open
  end
  
  def collection_options
    @collections_map.keys
  end
  
  def palette_options
    PALETTES
  end
  
  def style_options
    STYLES
  end
  
  def initialize_punk_directory
    @punk_directory = @punk_config_directory = OUTPUT_LOCATION_DEFAULT
    FileUtils.mkdir_p(@punk_directory)
  end
  
  def initialize_collections_map
    begin
      http_response = Net::HTTP.get_response(URI(COLLECTIONS_YAML_URL))
      if http_response.is_a?(Net::HTTPSuccess)
        @collections_map = YAML.load(http_response.body)
      else
        raise "code: #{http_response.code} message: #{http_response.message}"
      end
    rescue StandardError, SocketError => e
      puts "Failed to utilize collection YAML from: #{COLLECTIONS_YAML_URL}"
      puts e.full_message
      puts "Utilizing local collection YAML instead: #{COLLECTIONS_YAML_PATH}"
      @collections_map = YAML.load(File.read(COLLECTIONS_YAML_PATH))
    end
  end
  
  def initialize_collection
    return if @collection && @collection == @last_collection
    @collection ||= @collections_map.keys.first
    url = @collections_map[@collection][:url]
    width = @collections_map[@collection][:width]
    height = @collections_map[@collection][:height]
    @punk_file = File.join(@punk_config_directory, File.basename(url, '.png'))
    File.write(@punk_file, Net::HTTP.get(URI(url))) unless File.exist?(@punk_file)
    @images ||= {}
    @images[@collection] ||= Punks::Image::Composite.read(@punk_file, width: width, height: height)
    @last_collection = @collection
    self.image_index = 0
    @image_index_spinbox.to = @images[@collection].size - 1 if @image_index_spinbox
  end
  
  def load_config
    @punk_config_file = File.join(@punk_config_directory, 'cryptopunks.yml')
    FileUtils.touch(@punk_config_file)
    @punk_config = YAML.load(File.read(@punk_config_file)) || {punk_directory: @punk_directory}
    @punk_directory = @punk_config[:punk_directory]
  end
  
  def save_config
    File.write(@punk_config_file, YAML.dump(@punk_config))
  end
  
  def initialize_defaults
    @collection = @collections_map.keys.first
    @zoom = 12
    @palette = PALETTES.first
    @style = STYLES.first
    @led_spacing = 2
    @led_round_corner = false
    @sketch_line = 1
    @mirror = false
    @flip = false
  end
  
  def observe_image_attribute_changes
    observer = Glimmer::DataBinding::Observer.proc { generate_image }
    observer.observe(self, :collection)
    observer.observe(self, :image_index)
    observer.observe(self, :zoom)
    observer.observe(self, :palette)
    observer.observe(self, :style)
    observer.observe(self, :led_spacing)
    observer.observe(self, :led_round_corner)
    observer.observe(self, :sketch_line)
    observer.observe(self, :mirror)
    observer.observe(self, :flip)
  end
  
  def generate_image
    initialize_collection
    return if @image_index.to_i > @images[@collection].size
    image_location = File.join(@punk_directory, "#{@collection.gsub(' ', '').downcase}-#{@image_index}#{"x#{@zoom}" if @zoom.to_i > 1}#{"-#{@palette.underscore}" if @palette != PALETTES.first}#{"-#{@style.underscore}" if @style != STYLES.first}.png")
    puts "Writing punk image to #{image_location}"
    selected_punk = @images[@collection][@image_index.to_i]
    selected_punk = selected_punk.change_palette8bit(Palette8bit.const_get(@palette.gsub(' ', '_').upcase.to_sym)) if @palette != PALETTES.first
    @original_zoom = @zoom
    if @previous_collection && @collection != @previous_collection && @collections_map[@collection][:width] != @collections_map[@previous_collection][:width]
      @zoom = @collections_map[@collection][:default_zoom]
    end
    if @style != STYLES.first
      style_options = {}
      if @style == 'Led'
        style_options[:spacing] = @led_spacing.to_i
        style_options[:round_corner] = @led_round_corner
      end
      if @style == 'Sketch'
        style_options[:line] = @sketch_line.to_i
      end
      selected_punk = selected_punk.send(@style.underscore, @zoom.to_i, **style_options)
    end
    selected_punk = selected_punk.mirror if @mirror
    selected_punk = selected_punk.flip if @flip
    selected_punk = selected_punk.zoom(@zoom.to_i) if @style == STYLES.first
    selected_punk.save(image_location)
    @image_label.image = image_location
    @output_location_entry.text = image_location
    @previous_style = @style
    @previous_collection = @collection
    notify_observers(:zoom) if @zoom != @original_zoom
  end
  
  def create_gui
    @root = root {
      title 'CryptoPunks GUI'
      iconphoto File.expand_path('../icons/cryptopunks-gui.png', __dir__)
      
      menu {
        if OS.mac?
          menu(:application) {
            menu_item(:about, label: 'About') {
              accelerator 'Command+A'
              
              on('command') do
                show_about_dialog
              end
            }
            
            menu_item(:preferences) {
              on('command') do
                show_preferences_dialog
              end
            }
          }
        end
        
        menu(label: 'File', underline: 0) {
          menu_item(label: 'Change Output Location...', underline: 7) {
            on('command') do
              change_output_location
            end
          }
          
          menu_item(label: 'Reset Output Location', underline: 0) {
            on('command') do
              reset_output_location
            end
          }
        }
        
        menu(label: 'Help')
      }
      
      frame {
        label {
          text 'Collection:'
        }
        combobox {
          readonly true
          text <=> [self, :collection]
        }
        
        label {
          text 'Image Index:'
        }
        @image_index_spinbox = spinbox {
          from 0
          to @images[@collection].size - 1
          text <=> [self, :image_index]
        }
        
        label {
          text 'Zoom:'
        }
        spinbox {
          from 1
          to 72
          text <=> [self, :zoom]
        }
        
        label {
          text 'Palette:'
        }
        combobox {
          readonly true
          text <=> [self, :palette]
        }
        
        label {
          text 'Style:'
        }
        combobox {
          readonly true
          text <=> [self, :style, after_write: ->(val) {add_style_options}]
        }
        
        @style_options_frame = frame {
          padding 0
        }
        
        frame {
          padding 0
          
          checkbutton {
            grid row: 0, column: 0, column_weight: 0
            variable <=> [self, :mirror]
          }
          label {
            grid row: 0, column: 1
            text 'Mirror'
            
            on('Button-1') do
              self.mirror = !mirror
            end
          }
          
          checkbutton {
            grid row: 0, column: 2
            variable <=> [self, :flip]
          }
          label {
            grid row: 0, column: 3
            text 'Flip'
            
            on('Button-1') do
              self.flip = !flip
            end
          }
        }
        
        label {
          text 'Output Location:'
        }
        frame {
          padding 0
          
          @output_location_entry = entry {
            grid row: 0, column: 0
            readonly true
            width 47
          }
          button {
            grid row: 0, column: 1
            text '...'
            width 1.1
            
            on('command') do
              change_output_location
            end
          }
        }
        
        @image_label = label {
          grid row_weight: 1
        }
      }
    }
  end
  
  def add_style_options
    @style_options_frame.content {
      @style_options_frame.children.each(&:destroy)
      if @style == 'Led'
        frame {
          padding 0
          
          label {
            grid row: 0, column: 0, column_weight: 0
            text 'Spacing:'
          }
          spinbox {
            grid row: 0, column: 1
            from 1
            to 72
            text <=> [self, :led_spacing]
          }
          
          checkbutton {
            grid row: 0, column: 2
            variable <=> [self, :led_round_corner]
          }
          label {
            grid row: 0, column: 3
            text 'Round Corner'
            
            on('Button-1') do
              self.led_round_corner = !led_round_corner
            end
          }
        }
      elsif @style == 'Sketch'
        frame {
          padding 0
          
          label {
            grid row: 0, column: 0, column_weight: 0
            text 'Line:'
          }
          spinbox {
            grid row: 0, column: 1
            from 1
            to 72
            text <=> [self, :sketch_line]
          }
        }
      else
        frame { # filler
          padding 0
          height 0
          width 0
        }
      end
    }
  end
  
  def change_output_location
    new_punk_directory = choose_directory(parent: @root)
    unless new_punk_directory.to_s.empty?
      @punk_directory = new_punk_directory
      @punk_config[:punk_directory] = @punk_directory
      save_config
      generate_image
    end
  end
  
  def reset_output_location
    @punk_directory = OUTPUT_LOCATION_DEFAULT
    @punk_config[:punk_directory] = @punk_directory
    save_config
    generate_image
  end
  
  def show_about_dialog
    message_box('CryptoPunks GUI', "Copyright (c) 2021 Crypto Punk's Not Dead")
  end
  
  def show_preferences_dialog
    toplevel(@root) { |tl|
      title 'Preferences'
    }
  end
end

CryptopunksGui.new.launch

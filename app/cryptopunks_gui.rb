require 'glimmer-dsl-tk'
require 'cryptopunks'
require 'facets'
require 'fileutils'
require 'net/http'
require 'uri'
require 'glimmer/data_binding/observer'
require 'puts_debuggerer'

class CryptopunksGui
  include Glimmer
  
  PALETTES = ['Standard'] + (Palette8bit.constants).map(&:name).map {|palette| palette.split('_').map(&:capitalize).join(' ')}.reject { |palette| palette.include?(' ') }.sort
  STYLES = ['Normal', 'Led', 'Sketch']
  
  attr_accessor :punk_index, :zoom, :palette, :style, :flip, :mirror
  
  def initialize
    initialize_punks
    initialize_defaults
    observe_image_attribute_changes
    create_gui
    self.punk_index = 0
    @root.open
  end
  
  def palette_options
    PALETTES
  end
  
  def style_options
    STYLES
  end
  
  def initialize_punks
    @punk_directory = File.join(Dir.home, '.cryptopunks')
    FileUtils.mkdir_p(@punk_directory)
    @punk_file = File.join(@punk_directory, 'punks.png')
    File.write(@punk_file, Net::HTTP.get(URI('https://raw.githubusercontent.com/larvalabs/cryptopunks/master/punks.png'))) unless File.exist?(@punk_file)
    @punks = Punks::Image::Composite.read(@punk_file)
  end
  
  def initialize_defaults
    @zoom = 12
    @palette = PALETTES.first
    @style = STYLES.first
    @mirror = false
    @flip = false
  end
  
  def observe_image_attribute_changes
    observer = Glimmer::DataBinding::Observer.proc { generate_image }
    observer.observe(self, :punk_index)
    observer.observe(self, :zoom)
    observer.observe(self, :palette)
    observer.observe(self, :style)
    observer.observe(self, :mirror)
    observer.observe(self, :flip)
  end
  
  def generate_image
    image_location = File.join(@punk_directory, "punk-#{@punk_index}#{"x#{@zoom}" if @zoom.to_i > 1}#{"-#{@palette.underscore}" if @palette != PALETTES.first}#{"-#{@style.underscore}" if @style != STYLES.first}.png")
    puts "Writing punk image to #{image_location}"
    selected_punk = @punks[@punk_index.to_i]
    selected_punk = selected_punk.change_palette8bit(Palette8bit.const_get(@palette.gsub(' ', '_').upcase.to_sym)) if @palette != PALETTES.first
    @original_zoom = @zoom
    selected_punk = selected_punk.send(@style.underscore, @zoom.to_i) if @style != STYLES.first
    selected_punk = selected_punk.mirror if @mirror
    selected_punk = selected_punk.flip if @flip
    selected_punk = selected_punk.zoom(@zoom.to_i) if @style == STYLES.first
    selected_punk.save(image_location)
    @image_label.image = image_location
    @message_entry.text = image_location
    @previous_style = @style
    notify_observers(:zoom) if @zoom != @original_zoom
  end
  
  def create_gui
    @root = root {
      title 'CryptoPunks GUI'
      iconphoto File.expand_path('../icons/cryptopunks-gui.png', __dir__)
      
      frame {
        label {
          text 'Select Punk Index and Zoom To Mint Cryptopunk'
          font weight: 'bold'
        }
        
        label {
          text 'Punk Index:'
        }
        spinbox {
          from 0
          to @punks.size - 1
          text <=> [self, :punk_index]
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
          text <=> [self, :style]
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
        @message_entry = entry {
          readonly true
        }
        
        @image_label = label {
          grid row_weight: 1
        }
      }
    }
  end
end

CryptopunksGui.new.launch

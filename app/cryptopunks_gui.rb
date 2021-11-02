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
  COLLECTION_URL_MAP = {
    'Punks' => {url: 'https://raw.githubusercontent.com/larvalabs/cryptopunks/master/punks.png', width: 24, height: 24, default_zoom: 12},
    'Mohawks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/mohawks.png', width: 24, height: 24, default_zoom: 12},
    'Blondies' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/blondies.png', width: 24, height: 24, default_zoom: 12},
    'Zombies' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/zombies.png', width: 24, height: 24, default_zoom: 12},
    'Apes' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/apes.png', width: 24, height: 24, default_zoom: 12},
    'Aliens' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/aliens.png', width: 24, height: 24, default_zoom: 12},
    'Golden Punks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/goldenpunks.png', width: 24, height: 24, default_zoom: 12},
    'Halloween Punks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/halloweenpunks.png', width: 24, height: 24, default_zoom: 12},
    'Scream Punks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/cryptopunks/master/halloween/i/screampunks%402x.png', width: 48, height: 48, default_zoom: 6},
    "Jack 'O' Lantern Punks" => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/cryptopunks/master/halloween/i/jackpunks%402x.png', width: 48, height: 48, default_zoom: 6},
    'Joker Punks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/cryptopunks/master/halloween/i/jokerpunks%402x.png', width: 48, height: 48, default_zoom: 6},
    'Frankenstein Punks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/cryptopunks/master/halloween/i/frankensteinpunks%402x.png', width: 48, height: 48, default_zoom: 6},
    'Front Punks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/frontpunks.png', width: 24, height: 24, default_zoom: 12},
    'More Punks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/morepunks.png', width: 24, height: 24, default_zoom: 12},
    'Expansion Punks' => {url: 'https://expansionpunks.com/provenance/expansionpunks.png', width: 24, height: 24, default_zoom: 12},
    'Avalanche Punks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/avalanchepunks.png', width: 24, height: 24, default_zoom: 12},
    'International Punks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/intlpunks.png', width: 24, height: 24, default_zoom: 12},
    'Ape Punks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/apepunks.png', width: 24, height: 24, default_zoom: 12},
    'Alien Clan' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/alienclan.png', width: 24, height: 24, default_zoom: 12},
    'Bored Apes' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes.png', width: 28, height: 28, default_zoom: 10},
    'Bored Apes Blue' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_blue.png', width: 28, height: 28, default_zoom: 10},
    'Bored Apes Red' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_red.png', width: 28, height: 28, default_zoom: 10},
    'Bored Apes Neon Glow' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_neon_glow.png', width: 28, height: 28, default_zoom: 10},
    'Bored Apes Stars and Stripes' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_stars_and_stripes.png', width: 28, height: 28, default_zoom: 10},
    'Bored Apes Acid' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_acid.png', width: 28, height: 28, default_zoom: 10},
    'Cool Cats' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats.png', width: 24, height: 24, default_zoom: 12},
    'Cool Cats Mohawks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_mohawks.png', width: 24, height: 24, default_zoom: 12},
    'Cool Cats Ninjas' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_ninjas.png', width: 24, height: 24, default_zoom: 12},
    'Cool Cats TV Heads' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_tvheads.png', width: 24, height: 24, default_zoom: 12},
    'Cool Cats Pirates' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_pirates.png', width: 24, height: 24, default_zoom: 12},
    'Cool Cats Unicorns' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_unicorns.png', width: 24, height: 24, default_zoom: 12},
    'Cool Cats Dragons' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_dragons.png', width: 24, height: 24, default_zoom: 12},
    'Cool Cats Frogs' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_frogs.png', width: 24, height: 24, default_zoom: 12},
    'Pudgy Penguins' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/pudgypenguins.png', width: 24, height: 24, default_zoom: 12},
    'Dodge' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/dodge.png', width: 24, height: 24, default_zoom: 12},
    'Rocks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/rocks.png', width: 24, height: 24, default_zoom: 12},
    'Punk Rocks' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/punkrocks.png', width: 24, height: 24, default_zoom: 12},
    'Tulips' => {url: 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/tulips.png', width: 24, height: 24, default_zoom: 12},
  }
  
  attr_accessor :collection, :image_index, :zoom, :palette, :style, :led_spacing, :led_round_corner, :sketch_line, :flip, :mirror
  
  def initialize
    initialize_punk_directory
    initialize_collection
    load_config
    initialize_defaults
    observe_image_attribute_changes
    create_gui
    self.image_index = 0
    @root.open
  end
  
  def collection_options
    COLLECTION_URL_MAP.keys
  end
  
  def palette_options
    PALETTES
  end
  
  def style_options
    STYLES
  end
  
  def initialize_punk_directory
    @punk_directory = @punk_config_directory = File.join(Dir.home, 'cryptopunks')
    FileUtils.mkdir_p(@punk_directory)
  end
  
  def initialize_collection
    return if @collection && @collection == @last_collection
    @collection ||= COLLECTION_URL_MAP.keys.first
    url = COLLECTION_URL_MAP[@collection][:url]
    width = COLLECTION_URL_MAP[@collection][:width]
    height = COLLECTION_URL_MAP[@collection][:height]
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
    @collection = COLLECTION_URL_MAP.keys.first
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
    if @previous_collection && @collection != @previous_collection && COLLECTION_URL_MAP[@collection][:width] != COLLECTION_URL_MAP[@previous_collection][:width]
      @zoom = COLLECTION_URL_MAP[@collection][:default_zoom]
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
              new_punk_directory = choose_directory(parent: @root)
              unless new_punk_directory.to_s.empty?
                @punk_directory = new_punk_directory
                @punk_config[:punk_directory] = @punk_directory
                save_config
                generate_image
              end
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
end

CryptopunksGui.new.launch

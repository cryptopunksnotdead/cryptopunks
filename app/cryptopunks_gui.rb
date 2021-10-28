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
    'Punks' => 'https://raw.githubusercontent.com/larvalabs/cryptopunks/master/punks.png',
    'Mohawks' => 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/mohawks.png',
    'Blondies' => 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/blondies.png',
    'Zombies' => 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/zombies.png',
    'Apes' => 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/apes.png',
    'Aliens' => 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/aliens.png',
    'Golden Punks' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/goldenpunks.png',
    'Halloween Punks' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/halloweenpunks.png',
    'Front Punks' => 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/frontpunks.png',
    'More Punks' => 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/morepunks.png',
    'Expansion Punks' => 'https://expansionpunks.com/provenance/expansionpunks.png',
    'Avalanche Punks' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/avalanchepunks.png',
    'Intl Punks' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/intlpunks.png',
    'Ape Punks' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/apepunks.png',
    'Alien Clan' => 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/alienclan.png',
    'Bored Apes Blue' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_blue.png',
    'Bored Apes Red' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_red.png',
    'Bored Apes Neon Glow' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_neon_glow.png',
    'Bored Apes Stars and Stripes' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_stars_and_stripes.png',
    'Bored Apes Acid' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/boredapes_acid.png',
    'Cool Cats' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats.png',
    'Cool Cats Mohawks' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_mohawks.png',
    'Cool Cats Ninjas' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_ninjas.png',
    'Cool Cats TV Heads' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_tvheads.png',
    'Cool Cats Pirates' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_pirates.png',
    'Cool Cats Unicorns' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_unicorns.png',
    'Cool Cats Dragons' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_dragons.png',
    'Cool Cats Frogs' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/coolcats_frogs.png',
    'Pudgy Penguins' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/pudgypenguins.png',
    'Dodge' => 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/dodge.png',
    'Rocks' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/rocks.png',
    'Punk Rocks' => 'https://raw.githubusercontent.com/cryptopunksnotdead/programming-cryptopunks/master/i/punkrocks.png',
    'Tulips' => 'https://raw.githubusercontent.com/cryptopunksnotdead/awesome-24px/master/collection/tulips.png',
  }
  
  attr_accessor :collection, :punk_index, :zoom, :palette, :style, :led_spacing, :led_round_corner, :sketch_line, :flip, :mirror
  
  def initialize
    initialize_punk_directory
    initialize_collection
    load_config
    initialize_defaults
    observe_image_attribute_changes
    create_gui
    self.punk_index = 0
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
    url = COLLECTION_URL_MAP[@collection]
    @punk_file = File.join(@punk_config_directory, File.basename(url, '.png'))
    File.write(@punk_file, Net::HTTP.get(URI(url))) unless File.exist?(@punk_file)
    @punks = Punks::Image::Composite.read(@punk_file)
    @last_collection = @collection
    self.punk_index = 0
    @punk_index_spinbox.to = @punks.size - 1 if @punk_index_spinbox
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
    observer.observe(self, :punk_index)
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
    return if @punk_index.to_i > @punks.size
    image_location = File.join(@punk_directory, "#{@collection.gsub(' ', '').downcase}-#{@punk_index}#{"x#{@zoom}" if @zoom.to_i > 1}#{"-#{@palette.underscore}" if @palette != PALETTES.first}#{"-#{@style.underscore}" if @style != STYLES.first}.png")
    puts "Writing punk image to #{image_location}"
    selected_punk = @punks[@punk_index.to_i]
    selected_punk = selected_punk.change_palette8bit(Palette8bit.const_get(@palette.gsub(' ', '_').upcase.to_sym)) if @palette != PALETTES.first
    @original_zoom = @zoom
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
          text 'Punk Index:'
        }
        @punk_index_spinbox = spinbox {
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
              @punk_directory = choose_directory(parent: @root)
              @punk_config[:punk_directory] = @punk_directory
              save_config
              generate_image
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

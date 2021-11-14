require 'glimmer-dsl-tk'
require 'cryptopunks'
require 'facets'
require 'fileutils'
require 'net/http'
require 'uri'
require 'glimmer/data_binding/observer'
require 'yaml'
require 'puts_debuggerer'

require_relative 'model/image'
require_relative 'view/menu_bar'

class CryptopunksGui
  include Glimmer
  include View::MenuBar
  
  def initialize
    @image = Model::Image.new
    create_gui
    register_observers
    @image.image_index = 0
  end
  
  def launch
    @root.open
  end
  
  def register_observers
    Glimmer::DataBinding::Observer.proc do
      @image_label.image = @output_location_entry.text = @image.image_location
    end.observe(@image, :image_location)
    
    Glimmer::DataBinding::Observer.proc do
      @image_index_spinbox.to = @image.images[@image.collection].size - 1 if @image_index_spinbox
    end.observe(@image, :images)
  end

  def create_gui
    @root = root {
      title 'CryptoPunks GUI'
      iconphoto File.expand_path('../icons/cryptopunks-gui.png', __dir__)
      
      cryptopunks_gui_menu_bar
      
      frame {
        label {
          text 'Collection:'
        }
        combobox {
          readonly true
          text <=> [@image, :collection]
        }
        
        label {
          text 'Image Index:'
        }
        @image_index_spinbox = spinbox {
          from 0
          to @image.images[@image.collection].size - 1
          text <=> [@image, :image_index]
        }
        
        label {
          text 'Zoom:'
        }
        spinbox {
          from 1
          to 72
          text <=> [@image, :zoom]
        }
        
        label {
          text 'Palette:'
        }
        combobox {
          readonly true
          text <=> [@image, :palette]
        }
        
        label {
          text 'Style:'
        }
        combobox {
          readonly true
          text <=> [@image, :style, after_write: ->(val) {add_style_options}]
        }
        
        @style_options_frame = frame {
          padding 0
        }
        
        frame {
          padding 0
          
          checkbutton {
            grid row: 0, column: 0, column_weight: 0
            variable <=> [@image, :mirror]
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
            variable <=> [@image, :flip]
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
            text <=> [@image, :led_spacing]
          }
          
          checkbutton {
            grid row: 0, column: 2
            variable <=> [@image, :led_round_corner]
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
            text <=> [@image, :sketch_line]
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
    @image.change_output_location(new_punk_directory) unless new_punk_directory.to_s.empty?
  end
end

CryptopunksGui.new.launch

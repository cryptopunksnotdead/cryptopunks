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

class CryptopunksGui
  include Glimmer
  
  LICENSE = File.expand_path('../LICENSE.txt', __dir__)
  HELP = File.expand_path('../README.md', __dir__)
  
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
    observe_image_attribute_changes
    
    Glimmer::DataBinding::Observer.proc do
      @image_label.image = @output_location_entry.text = @image.image_location
    end.observe(@image, :image_location)
    
    Glimmer::DataBinding::Observer.proc do
      @image_index_spinbox.to = @image.images[@image.collection].size - 1 if @image_index_spinbox
    end.observe(@image, :images)
  end

  def observe_image_attribute_changes
    observer = Glimmer::DataBinding::Observer.proc do
      @image.generate_image
    end
    observer.observe(@image, :collection)
    observer.observe(@image, :image_index)
    observer.observe(@image, :zoom)
    observer.observe(@image, :palette)
    observer.observe(@image, :style)
    observer.observe(@image, :led_spacing)
    observer.observe(@image, :led_round_corner)
    observer.observe(@image, :sketch_line)
    observer.observe(@image, :mirror)
    observer.observe(@image, :flip)
  end
  
  def create_gui
    @root = root {
      title 'CryptoPunks GUI'
      iconphoto File.expand_path('../icons/cryptopunks-gui.png', __dir__)
      
      menu {
        if OS.mac?
          menu(:application) {
            menu_item(:about, label: 'About') {
              accelerator OS.mac? ? 'Command+Shift+A' : 'Control+Alt+A'
              
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
            accelerator OS.mac? ? 'Command+O' : 'Control+O'
            
            on('command') do
              change_output_location
            end
          }
          
          menu_item(label: 'Reset Output Location', underline: 0) {
            on('command') do
              reset_output_location
            end
          }
          
          menu_item(:separator)
          
          menu_item(label: 'Preferences...', underline: 0) {
            on('command') do
              show_preferences_dialog
            end
          }
        
          menu_item(:separator)
          
          menu_item(label: 'Exit', underline: 1) {
            on('command') do
              exit(0)
            end
          }
        }
        
        menu(label: 'Help') {
          menu_item(:help) {
            on('command') do
              show_help_dialog
            end
          }
        }
      }
      
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
          
  def reset_output_location
    @image.reset_output_location
  end

  def show_about_dialog
    message_box(parent: @root, title: 'CryptoPunks GUI', message: "CryptoPunks GUI\n\n#{license}")
  end
  
  def show_preferences_dialog
    toplevel(@root) { |tl|
      title 'Preferences'
      width 1030
      height 700
      escapable true
      
      scrollbar_frame {
        @image.collections_map.each_with_index do |pair, index|
          collection_name, collection_options = pair
          
          label {
            grid row: index, column: 0, column_weight: 1
            text collection_name
          }
          
          entry {
            grid row: index, column: 1, column_weight: index == 0 ? 1 : 0
            text collection_options[:url]
            width 90
          }
        end
      }
    }
  end
  
  def show_help_dialog
    toplevel(@root) {
      title 'CryptoPunks GUI README.md'
      escapable true
      width 800
      height 600
      
      help_dialog = text {
        grid row: 0, column: 0, row_weight: 1, column_weight: 1
        value help
      }
      
      help_dialog_yscrollbar = scrollbar {
        grid row: 0, column: 1
        orient 'vertical'
      }
      help_dialog.yscrollbar help_dialog_yscrollbar.tk
      
      help_dialog_xscrollbar = scrollbar {
        grid row: 1, column: 0, column_span: 2
        orient 'horizontal'
      }
      help_dialog.xscrollbar help_dialog_xscrollbar.tk
    }
  end
  
  def license
    @license ||= File.read(LICENSE)
  end
  
  def help
    @help ||= File.read(HELP)
  end
end

CryptopunksGui.new.launch

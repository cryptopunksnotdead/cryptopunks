class CryptopunksGui
  module View
    module MenuBar
      LICENSE = File.expand_path('../../LICENSE.txt', __dir__)
      HELP = File.expand_path('../../README.md', __dir__)
    
      def cryptopunks_gui_menu_bar(root: , image: )
        menu {
          if OS.mac?
            menu(:application) {
              menu_item(:about, label: 'About') {
                accelerator OS.mac? ? 'Command+Shift+A' : 'Control+Alt+A'
                
                on('command') do
                  show_about_dialog(root: root)
                end
              }
              
              menu_item(:preferences) {
                on('command') do
                  show_preferences_dialog(root: root, image: image)
                end
              }
            }
          end
          
          menu(label: 'File', underline: 0) {
            menu_item(label: 'Change Output Location...', underline: 7) {
              accelerator OS.mac? ? 'Command+O' : 'Control+O'
              
              on('command') do
                change_output_location(root: root, image: image)
              end
            }
            
            menu_item(label: 'Reset Output Location', underline: 0) {
              on('command') do
                image.reset_output_location
              end
            }
            
            menu_item(:separator)
            
            menu_item(label: 'Preferences...', underline: 0) {
              on('command') do
                show_preferences_dialog(root: root, image: image)
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
                show_help_dialog(root: root)
              end
            }
          }
        }
      end
          
      def show_about_dialog(root: )
        message_box(parent: root, title: 'CryptoPunks GUI', message: "CryptoPunks GUI\n\n#{license}")
      end
      
      def show_preferences_dialog(root: , image: )
        toplevel(root) { |tl|
          title 'Preferences'
          width 1030
          height 700
          escapable true
          
          scrollbar_frame {
            image.collections_map.each_with_index do |pair, index|
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
      
      def show_help_dialog(root: )
        toplevel(root) {
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
  end
end

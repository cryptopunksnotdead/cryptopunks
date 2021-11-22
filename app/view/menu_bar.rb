# require_relative 'preferences_dialog'
require_relative 'help_dialog'

class CryptopunksGui
  module View
    module MenuBar
#       include View::PreferencesDialog
      include View::HelpDialog
      
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
              
#               menu_item(:preferences) {
#                 on('command') do
#                   preferences_dialog(root: root, image: image)
#                 end
#               }
            }
          end
          
          menu(label: 'File', underline: 0) {
            menu_item(label: 'Change Output Location...', underline: 7) {
              accelerator OS.mac? ? 'Command+O' : 'Control+O'
              
              on('command') do
                change_output_location(root: root, image: image) # assumes View::ImageFrame is mixed in
              end
            }
            
            menu_item(label: 'Reset Output Location', underline: 0) {
              on('command') do
                image.reset_output_location
              end
            }
            
            menu_item(:separator)
            
#             menu_item(label: 'Preferences...', underline: 0) {
#               on('command') do
#                 preferences_dialog(root: root, image: image)
#               end
#             }
          
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
                help_dialog(root: root)
              end
            }
          }
        }
      end
          
      def show_about_dialog(root: )
        message_box(parent: root, title: 'CryptoPunks GUI', message: "CryptoPunks GUI\n\n#{license}")
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

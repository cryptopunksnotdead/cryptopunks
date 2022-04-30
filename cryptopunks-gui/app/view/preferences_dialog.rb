class CryptopunksGui
  module View
    module PreferencesDialog
      def preferences_dialog(root: , image: )
        toplevel(root) {
          title 'Preferences'
          width 1280
          height 700
          escapable true
          
          scrollbar_frame {
            label {
              grid row: 0, column: 0
              text ''
            }
            
            label {
              grid row: 0, column: 1
              text 'Collection Name'
            }
            
            label {
              grid row: 0, column: 2
              text 'URL'
              width 82
            }
            
            label {
              grid row: 0, column: 3
              text 'Width'
              width 3
            }
            
            label {
              grid row: 0, column: 4
              text 'Height'
              width 3
            }
            
            label {
              grid row: 0, column: 5
              text "Default\nZoom"
              width 3
            }
            
            label {
              grid row: 0, column: 6, column_span: 3
              text 'Actions'
            }
            
            image.collections_map.each_with_index do |pair, index|
              collection_name, collection_options = pair
              row = index + 1
              
              checkbutton { |cb|
                grid row: row, column: 0
                # TODO consider using hash_proxy object to bind more effectively
                variable <= [image.collections_map[collection_name], :enabled]
                
                on('command') do
                  collection_options[:enabled] = cb.variable
                end
              }
              
              entry {
                grid row: row, column: 1
                text collection_name
              }
              
              entry {
                grid row: row, column: 2
                text collection_options[:url]
                width 82
              }
              
              spinbox {
                grid row: row, column: 3
                from 1
                to 512
                text collection_options[:width]
                width 3
              }
              
              spinbox {
                grid row: row, column: 4
                from 1
                to 512
                text collection_options[:height]
                width 3
              }
              
              spinbox {
                grid row: row, column: 5
                from 1
                to 72
                text collection_options[:default_zoom]
                width 3
              }
              
              button {
                grid row: row, column: 6
                text 'X'
                width 1
              }
              button {
                grid row: row, column: 7
                text '^'
                width 1
              }
              button {
                grid row: row, column: 8
                text 'v'
                width 1
              }
            end
          
            row = image.collections_map.keys.size + 1
            
            checkbutton {
              grid row: row, column: 0
              
            }
            
            entry {
              grid row: row, column: 1
              text ''
            }
            
            entry {
              grid row: row, column: 2
              text ''
              width 82
            }
            
            spinbox {
              grid row: row, column: 3
              from 1
              to 512
              text '24'
              width 3
            }
            
            spinbox {
              grid row: row, column: 4
              from 1
              to 512
              text '24'
              width 3
            }
            
            spinbox {
              grid row: row, column: 5
              from 1
              to 72
              text '12'
              width 3
            }
          }
          
          frame {
            button {
              text 'Reset'
              
              on('command') do
                image.initialize_collections_map(reset: true)
                # TODO cause an update to all collections
              end
            }
          }
        }
      end
    end
  end
end

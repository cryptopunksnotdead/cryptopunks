class CryptopunksGui
  module View
    module PreferencesDialog
      def preferences_dialog(root: , image: )
        toplevel(root) {
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
    end
  end
end

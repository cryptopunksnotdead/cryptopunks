class CryptopunksGui
  module View
    module ImageFrame
      def image_frame(root: , image: )
        frame {
          label {
            text 'Collection:'
          }
          combobox {
            readonly true
            text <=> [image, :collection]
          }
          
          label {
            text 'Image Index:'
          }
          @image_index_spinbox = spinbox {
            from 0
            to @image.images[image.collection].size - 1
            text <=> [image, :image_index]
          }
          
          label {
            text 'Zoom:'
          }
          spinbox {
            from 1
            to 72
            text <=> [image, :zoom]
          }
          
          label {
            text 'Palette:'
          }
          combobox {
            readonly true
            text <=> [image, :palette]
          }
          
          label {
            text 'Style:'
          }
          combobox {
            readonly true
            text <=> [image, :style, after_write: ->(val) {add_style_options(image: image)}]
          }
          
          @style_options_container_frame = frame {
            padding 0
          }
          
          frame {
            padding 0
            
            checkbutton {
              grid row: 0, column: 0, column_weight: 0
              variable <=> [image, :mirror]
            }
            label {
              grid row: 0, column: 1
              text 'Mirror'
              
              on('Button-1') do
                image.mirror = !image.mirror
              end
            }
            
            checkbutton {
              grid row: 0, column: 2
              variable <=> [image, :flip]
            }
            label {
              grid row: 0, column: 3
              text 'Flip'
              
              on('Button-1') do
                image.flip = !image.flip
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
      end
      
      def add_style_options(image: )
        @style_options_container_frame.children.each(&:destroy)
        @style_options_container_frame.content {
          case image.style
          when 'Led'
            led_style_options_frame(image: image)
          when 'Sketch'
            sketch_style_options_frame(image: image)
          else
            no_style_options_frame
          end
        }
      end
    end
  end
end

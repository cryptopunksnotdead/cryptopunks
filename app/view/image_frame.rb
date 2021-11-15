class CryptopunksGui
  module View
    module ImageFrame
      def image_frame(root: , image: )
        image_label = output_location_entry = image_index_spinbox = style_options_container_frame = nil
        
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
          image_index_spinbox = spinbox {
            from 0
            to image.images[image.collection].size - 1
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
            text <=> [image, :style, after_write: ->(val) {add_style_options(style_options_container_frame: style_options_container_frame, image: image)}]
          }
          
          style_options_container_frame = frame {
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
            
            output_location_entry = entry {
              grid row: 0, column: 0
              readonly true
              width 47
            }
            button {
              grid row: 0, column: 1
              text '...'
              width 1.1
              
              on('command') do
                change_output_location(root: root, image: image)
              end
            }
          }
          
          image_label = label {
            grid row_weight: 1
          }
        }
        
        register_image_frame_observers(image_label: image_label, output_location_entry: output_location_entry, image_index_spinbox: image_index_spinbox, image: image)
      end
      
      def register_image_frame_observers(image_label: , output_location_entry: , image_index_spinbox: , image: )
        Glimmer::DataBinding::Observer.proc do
          image_label.image = output_location_entry.text = image.image_location
        end.observe(image, :image_location)
        
        Glimmer::DataBinding::Observer.proc do
          image_index_spinbox.to = image.images[image.collection].size - 1
        end.observe(image, :images)
      end
      
      def add_style_options(style_options_container_frame: , image: )
        style_options_container_frame.children.each(&:destroy)
        style_options_container_frame.content {
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
      
      def change_output_location(root: , image: )
        new_output_location = choose_directory(parent: root)
        image.change_output_location(new_output_location) unless new_output_location.to_s.empty?
      end
    end
  end
end

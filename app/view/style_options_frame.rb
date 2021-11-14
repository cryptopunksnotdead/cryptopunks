class CryptopunksGui
  module View
    module StyleOptionsFrame
      def led_style_options_frame
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
              @image.led_round_corner = !@image.led_round_corner
            end
          }
        }
      end
      
      def sketch_style_options_frame
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
      end
      
      def no_style_options_frame
        frame { # filler
          padding 0
          height 0
          width 0
        }
      end
    end
  end
end

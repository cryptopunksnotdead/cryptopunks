class CryptopunksGui
  module View
    module HelpDialog
      def help_dialog(root: )
        toplevel(root) {
          title 'CryptoPunks GUI - README.md'
          width 800
          height 600
          escapable true
          
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
    end
  end
end

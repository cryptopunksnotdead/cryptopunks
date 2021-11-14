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
require_relative 'view/image_frame'
require_relative 'view/style_options_frame'

class CryptopunksGui
  include Glimmer
  include View::MenuBar
  include View::ImageFrame
  include View::StyleOptionsFrame
  
  def initialize
    @image = Model::Image.new
    create_gui
    @image.image_index = 0
  end
  
  def launch
    @root.open
  end
  
  def create_gui
    @root = root { |root_proxy|
      title 'CryptoPunks GUI'
      iconphoto File.expand_path('../icons/cryptopunks-gui.png', __dir__)
      
      cryptopunks_gui_menu_bar(root: root_proxy, image: @image)
      
      image_frame(root: root_proxy, image: @image)
    }
  end
  
  def change_output_location(root: , image: )
    new_punk_directory = choose_directory(parent: root)
    image.change_output_location(new_punk_directory) unless new_punk_directory.to_s.empty?
  end
end

CryptopunksGui.new.launch

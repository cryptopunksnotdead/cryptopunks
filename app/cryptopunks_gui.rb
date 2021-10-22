require 'glimmer-dsl-tk'
require 'cryptopunks'
require 'fileutils'
require 'net/http'
require 'uri'
require 'glimmer/data_binding/observer'
require 'puts_debuggerer'

class CryptopunksGui
  include Glimmer
  
  attr_accessor :punk_index, :zoom
  
  def initialize
    @punk_directory = File.join(Dir.home, '.cryptopunks')
    FileUtils.mkdir_p(@punk_directory)
    @punk_file = File.join(@punk_directory, 'punks.png')
    File.write(@punk_file, Net::HTTP.get(URI('https://raw.githubusercontent.com/larvalabs/cryptopunks/master/punks.png'))) unless File.exist?(@punk_file)
    @punks = Punks::Image::Composite.read(@punk_file)
    @zoom = 12
    
    observer = Glimmer::DataBinding::Observer.proc do
      generate_image
    end
    observer.observe(self, :punk_index)
    observer.observe(self, :zoom)
    
    create_gui
    self.punk_index = 0
    @root.open
  end
  
  def generate_image
    image_location = File.join(@punk_directory, "punk-#{@punk_index}#{"x#{@zoom}" if @zoom.to_i > 1}.png")
    puts "Writing punk image to #{image_location}"
    selected_punk = @punks[@punk_index.to_i]
    selected_punk = selected_punk.zoom(@zoom.to_i)
    selected_punk.save(image_location)
    @image_label.image = image_location
    @message_entry.text = image_location
  end
  
  def create_gui
    @root = root {
      title 'Cryptopunks'
      
      frame {
        label {
          text 'Select Punk Index and Zoom To Mint Cryptopunk'
          font weight: 'bold'
        }
        
        label {
          text 'Punk Index:'
        }
        spinbox {
          from 0
          to @punks.size - 1
          text <=> [self, :punk_index]
        }
        
        label {
          text 'Zoom:'
        }
        spinbox {
          from 1
          to 72
          text <=> [self, :zoom]
        }
        
        label {
          text 'Output Location:'
        }
        @message_entry = entry {
          readonly true
        }
        
        @image_label = label {
          grid row_weight: 1
        }
      }
    }
  end
end

CryptopunksGui.new.launch

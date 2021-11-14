class CryptopunksGui
  module Model
    class Image
      PALETTES = ['Standard'] + (Palette8bit.constants).map(&:name).map {|palette| palette.split('_').map(&:capitalize).join(' ')}.reject { |palette| palette.include?(' ') }.sort
      STYLES = ['Normal', 'Led', 'Sketch']
      COLLECTIONS_YAML_URL = 'https://raw.githubusercontent.com/AndyObtiva/cryptopunks-gui/master/cryptopunks-collections.yml'
      COLLECTIONS_YAML_PATH = File.expand_path('../../cryptopunks-collections.yml', __dir__)
      OUTPUT_LOCATION_DEFAULT = File.join(Dir.home, 'cryptopunks')
      
      attr_accessor :collection, :collection_size, :image_index, :zoom, :palette, :style, :led_spacing, :led_round_corner, :sketch_line, :flip, :mirror,
                    :images, :image_location, :punk_directory, :punk_config
      
      def initialize
        initialize_punk_directory
        initialize_collections_map
        initialize_collection
        load_config
        initialize_defaults
      end
          
      def collection_options
        @collections_map.keys
      end
      
      def palette_options
        PALETTES
      end
      
      def style_options
        STYLES
      end
      
      def initialize_punk_directory
        @punk_directory = @punk_config_directory = OUTPUT_LOCATION_DEFAULT
        FileUtils.mkdir_p(@punk_directory)
      end
      
      def initialize_collections_map
        begin
          http_response = Net::HTTP.get_response(URI(COLLECTIONS_YAML_URL))
          if http_response.is_a?(Net::HTTPSuccess)
            @collections_map = YAML.load(http_response.body)
          else
            raise "code: #{http_response.code} message: #{http_response.message}"
          end
        rescue StandardError, SocketError => e
          puts "Failed to utilize collection YAML from: #{COLLECTIONS_YAML_URL}"
          puts e.full_message
          puts "Utilizing local collection YAML instead: #{COLLECTIONS_YAML_PATH}"
          @collections_map = YAML.load(File.read(COLLECTIONS_YAML_PATH))
        end
      end
      
      def initialize_collection
        return if @collection && @collection == @last_collection
        @collection ||= @collections_map.keys.first
        url = @collections_map[@collection][:url]
        width = @collections_map[@collection][:width]
        height = @collections_map[@collection][:height]
        @punk_file = File.join(@punk_config_directory, File.basename(url, '.png'))
        File.write(@punk_file, Net::HTTP.get(URI(url))) unless File.exist?(@punk_file)
        @images ||= {}
        @images[@collection] ||= Punks::Image::Composite.read(@punk_file, width: width, height: height)
        @last_collection = @collection
        self.image_index = 0
      end
      
      def load_config
        @punk_config_file = File.join(@punk_config_directory, 'cryptopunks.yml')
        FileUtils.touch(@punk_config_file)
        @punk_config = YAML.load(File.read(@punk_config_file)) || {punk_directory: @punk_directory}
        @punk_directory = @punk_config[:punk_directory]
      end
      
      def save_config
        File.write(@punk_config_file, YAML.dump(@punk_config))
      end
      
      def initialize_defaults
        @collection = @collections_map.keys.first
        @zoom = 12
        @palette = PALETTES.first
        @style = STYLES.first
        @led_spacing = 2
        @led_round_corner = false
        @sketch_line = 1
        @mirror = false
        @flip = false
      end
      
      def generate_image
        initialize_collection
        return if @image_index.to_i > @images[@collection].size
        self.image_location = File.join(@punk_directory, "#{@collection.gsub(' ', '').downcase}-#{@image_index}#{"x#{@zoom}" if @zoom.to_i > 1}#{"-#{@palette.underscore}" if @palette != PALETTES.first}#{"-#{@style.underscore}" if @style != STYLES.first}.png")
        puts "Writing punk image to #{@image_location}"
        selected_punk = @images[@collection][@image_index.to_i]
        selected_punk = selected_punk.change_palette8bit(Palette8bit.const_get(@palette.gsub(' ', '_').upcase.to_sym)) if @palette != PALETTES.first
        @original_zoom = @zoom
        if @previous_collection && @collection != @previous_collection && @collections_map[@collection][:width] != @collections_map[@previous_collection][:width]
          @zoom = @collections_map[@collection][:default_zoom]
        end
        if @style != STYLES.first
          style_options = {}
          if @style == 'Led'
            style_options[:spacing] = @led_spacing.to_i
            style_options[:round_corner] = @led_round_corner
          end
          if @style == 'Sketch'
            style_options[:line] = @sketch_line.to_i
          end
          selected_punk = selected_punk.send(@style.underscore, @zoom.to_i, **style_options)
        end
        selected_punk = selected_punk.mirror if @mirror
        selected_punk = selected_punk.flip if @flip
        selected_punk = selected_punk.zoom(@zoom.to_i) if @style == STYLES.first
        selected_punk.save(@image_location)
        @previous_style = @style
        @previous_collection = @collection
        notify_observers(:zoom) if @zoom != @original_zoom
      end
      
      def change_output_location(new_punk_directory)
        @punk_directory = new_punk_directory
        @punk_config[:punk_directory] = @punk_directory # TODO rename to something else
        save_config
        generate_image
      end
      
      def reset_output_location
        @punk_directory = OUTPUT_LOCATION_DEFAULT
        @punk_config[:punk_directory] = @punk_directory
        save_config
        generate_image
      end
    end
  end
end

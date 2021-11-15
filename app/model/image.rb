class CryptopunksGui
  module Model
    class Image
      PALETTES = ['Standard'] + (Palette8bit.constants).map(&:name).map {|palette| palette.split('_').map(&:capitalize).join(' ')}.reject { |palette| palette.include?(' ') }.sort
      STYLES = ['Normal', 'Led', 'Sketch']
      OUTPUT_LOCATION_DEFAULT = File.join(Dir.home, 'cryptopunks')
      CONFIG_FILE = File.join(OUTPUT_LOCATION_DEFAULT, 'cryptopunks.yml')
      COLLECTIONS_YAML_PATH = File.join(OUTPUT_LOCATION_DEFAULT, 'cryptopunks-collections.yml')
      COLLECTIONS_YAML_URL = 'https://raw.githubusercontent.com/cryptopunksnotdead/cryptopunks-gui/master/cryptopunks-collections.yml'
      COLLECTIONS_YAML_REPO_PATH = File.expand_path('../../cryptopunks-collections.yml', __dir__)
      
      attr_accessor :collection, :image_index, :zoom, :palette, :style, :led_spacing, :led_round_corner, :sketch_line, :flip, :mirror,
                    :collection_size, :collections_map, :images, :image_location, :output_location, :config
      
      def initialize
        initialize_output_location
        initialize_collections_map
        initialize_collection
        load_config
        initialize_defaults
        observe_image_attribute_changes
      end
          
      def collection_options
        @collections_map.keys.select {|collection_name| @collections_map[collection_name][:enabled]}
      end
      
      def palette_options
        PALETTES
      end
      
      def style_options
        STYLES
      end
      
      def initialize_output_location
        @output_location = OUTPUT_LOCATION_DEFAULT
        FileUtils.mkdir_p(@output_location)
      end
      
      def initialize_collections_map(reset: false)
        FileUtils.touch(COLLECTIONS_YAML_PATH)
        @collections_map = reset ? {} : (YAML.load(File.read(COLLECTIONS_YAML_PATH)) || {})
        new_collections_map = {}
        begin
          http_response = Net::HTTP.get_response(URI(COLLECTIONS_YAML_URL))
          if http_response.is_a?(Net::HTTPSuccess)
            new_collections_map = YAML.load(http_response.body)
          else
            raise "code: #{http_response.code} message: #{http_response.message}"
          end
        rescue StandardError, SocketError => e
          puts "Failed to utilize collection YAML from: #{COLLECTIONS_YAML_URL}"
          puts e.full_message
          puts "Utilizing local collection YAML instead: #{COLLECTIONS_YAML_REPO_PATH}"
          new_collections_map = YAML.load(File.read(COLLECTIONS_YAML_REPO_PATH)) rescue {}
        end
        @collections_map_observers ||= {}
        new_collections_map.each do |collection_name, collection_options|
          @collections_map[collection_name] ||= {}
          @collections_map[collection_name].reverse_merge!(collection_options)
          @collections_map[collection_name][:enabled] = true unless @collections_map[collection_name].has_key?(:enabled)
          @collections_map_observers[collection_name] ||= Glimmer::DataBinding::Observer.proc { |value, key|
            if key == :enabled
              self.collection = @collections_map.find { |name, options| options[:enabled] }.first if key == :enabled && value == false && @collection == collection_name
              notify_observers(:collection_options)
            end
            save_collections_map
          }.tap {|o| o.observe(@collections_map[collection_name])}
        end
        @collections_map_observer ||= Glimmer::DataBinding::Observer.proc { |collection_options, collection_name|
          if collection_options.nil?
            self.collection = @collections_map.find { |name, options| options[:enabled] }.first if @collection == collection_name
            self.collection = collection_name if @collections_map.select { |name, options| options[:enabled] }.count == 0
          end
          notify_observers(:collection_options)
          save_collections_map
        }.tap {|o| o.observe(@collections_map)}
        save_collections_map
      end
      
      def save_collections_map
        File.write(COLLECTIONS_YAML_PATH, YAML.dump(@collections_map))
      end
      
      def initialize_collection
        return if @collection && @collection == @last_collection
        @collection ||= @collections_map.keys.first
        url = @collections_map[@collection][:url]
        width = @collections_map[@collection][:width]
        height = @collections_map[@collection][:height]
        @image_file = File.join(OUTPUT_LOCATION_DEFAULT, File.basename(url, '.png'))
        File.write(@image_file, Net::HTTP.get(URI(url))) unless File.exist?(@image_file)
        @images ||= {}
        @images[@collection] ||= Punks::Image::Composite.read(@image_file, width: width, height: height)
        @last_collection = @collection
        self.image_index = 0
      end
      
      def load_config
        FileUtils.touch(CONFIG_FILE)
        @config = YAML.load(File.read(CONFIG_FILE)) || {}
        @output_location = @config[:output_location]
        @config[:output_location] = @output_location = OUTPUT_LOCATION_DEFAULT if @output_location.nil?
      end
      
      def save_config
        File.write(CONFIG_FILE, YAML.dump(@config))
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
      
      def observe_image_attribute_changes
        observer = Glimmer::DataBinding::Observer.proc { generate_image }
        observer.observe(self, :collection)
        observer.observe(self, :image_index)
        observer.observe(self, :zoom)
        observer.observe(self, :palette)
        observer.observe(self, :style)
        observer.observe(self, :led_spacing)
        observer.observe(self, :led_round_corner)
        observer.observe(self, :sketch_line)
        observer.observe(self, :mirror)
        observer.observe(self, :flip)
      end
      
      def generate_image
        initialize_collection
        return if @image_index.to_i >= @images[@collection].size
        new_image_location = File.join(@output_location, "#{@collection.gsub(' ', '').downcase}-#{@image_index}#{"x#{@zoom}" if @zoom.to_i > 1}#{"-#{@palette.underscore}" if @palette != PALETTES.first}#{"-#{@style.underscore}" if @style != STYLES.first}#{"-spacing#{@led_spacing.to_i}" if @style == 'Led'}#{'-round-corner' if @style == 'Led' && @led_round_corner}#{"-line#{@sketch_line.to_i}" if @style == 'Sketch'}#{'-mirror' if @mirror}#{'-flip' if @flip}.png")
        puts "Writing punk image to #{new_image_location}"
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
        selected_punk.save(new_image_location)
        self.image_location = new_image_location
        notify_observers(:zoom) if @zoom != @original_zoom
        @previous_style = @style
        @previous_collection = @collection
      end
      
      def change_output_location(new_output_location)
        @output_location = new_output_location
        @config[:output_location] = @output_location
        save_config
        generate_image
      end
      
      def reset_output_location
        @output_location = OUTPUT_LOCATION_DEFAULT
        @config[:output_location] = @output_location
        save_config
        generate_image
      end
    end
  end
end

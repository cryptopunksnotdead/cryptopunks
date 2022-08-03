module Marc

  class Spritesheet
    def self.builtin
      @builtin ||= Pixelart::Spritesheet.read(  "#{Pixelart::Module::Punks.root}/config/marcs-24x24.png",
                                                "#{Pixelart::Module::Punks.root}/config/marcs-24x24.csv",
                                                width:  24,
                                                height: 24 )
    end

    def self.find_by( name: )  ## return archetype/attribute image by name
       builtin.find_by( name: name )
    end
  end  # class Spritesheet
  ## add convenience (alternate spelling) alias - why? why not?
  SpriteSheet = Spritesheet
  Sheet       = Spritesheet
  Sprite      = Spritesheet



  class Image  <  Pixelart::Image
    def self.generator
      @generator ||= Artfactory.use( Sheet.builtin,
                                     image_class: Image )
    end


    NAMES = ['marc', 'marcs']
    DEFAULT_ATTRIBUTES = ['Marc']

    def self.generate( *names )
      ## note: return marcs "hand-phlipped" by default as phree phunks
      generator.generate( *names ).mirror
    end
  end # class Image


end #  module Marc


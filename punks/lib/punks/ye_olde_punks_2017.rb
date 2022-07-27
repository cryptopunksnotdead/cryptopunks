
module YeOldePunkAnno2017

  class Spritesheet
    def self.builtin
      @builtin ||= Pixelart::SpritesheetEx.read( "#{Pixelart::Module::Punks.root}/config/punks_2017-24x24.png",
                                                 "#{Pixelart::Module::Punks.root}/config/punks_2017-24x24.csv",
                                                 width:  24,
                                                 height: 24 )
    end

    ## note: for now class used for "namespace" only
    def self.find_by( name:, gender: nil, size: nil, warn: true )  ## return archetype/attribute image by name
       # note: pass along name as q (query string)
       builtin.find_by( name: name,
                        gender: gender,
                        size:   size,
                        warn: warn )
    end
  end  # class Spritesheet


  ## add convenience (alternate spelling) alias - why? why not?
  SpriteSheet = Spritesheet
  Sheet       = Spritesheet
  Sprite      = Spritesheet



  class Image < Pixelart::Image

    def self.generator
      @generator ||= GeneratorEx.use( Sheet.builtin, image_class: Image )
    end

    def self.generate( *values )
      generator.generate( *values )
    end # method Image.generate
  end # class Image
end # module YeOldePunkAnno2017


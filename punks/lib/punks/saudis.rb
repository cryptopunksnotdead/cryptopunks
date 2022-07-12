module Saudi

  class Spritesheet
    def self.builtin
      @builtin ||= Pixelart::Spritesheet.read(  "#{Pixelart::Module::Punks.root}/config/saudis-24x24.png",
                                                "#{Pixelart::Module::Punks.root}/config/saudis-24x24.csv",
                                                width:  24,
                                                height: 24 )
    end

    ## note: for now class used for "namespace" only
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
      @generator ||= Artfactory.use( Saudi::Sheet.builtin,
                                     image_class: Image )
    end


    # note: remove/delete empyty attributes (n/a - not applicables)
    ##      (e.g. "None" in Eyewear/Mouse Prop and
    ##            "Clean Shaven" in Beard )
    ##  future:  make n/a values configurable that you can pass in
    ##            e.g.   nas: [] or such - why? why not?
    NA = [
      'cleanshaven',
      'none'
    ]

    def self.generate( *names )
      names = names.filter { |name| !NA.include?( Pixelart::Spritesheet.normalize_key( name )) }

      generator.generate( *names )
    end
  end # class Image


end #  module Saudi


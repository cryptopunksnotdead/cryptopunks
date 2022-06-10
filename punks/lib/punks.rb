## 3rd party
require 'pixelart/base'
require 'backgrounds/base'
require 'artfactory/base'


## our own code
require 'punks/version'    # note: let version always go first



###
## add convenience pre-configurated generatored with build-in spritesheet (see config)

module Punkxl

  class Spritesheet
    def self.builtin
      @builtin ||= Pixelart::Spritesheet.read(  "#{Pixelart::Module::Punks.root}/config/punks_xl-32x32.png",
                                                "#{Pixelart::Module::Punks.root}/config/punks_xl-32x32.csv",
                                                width:  32,
                                                height: 32 )
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
      @generator ||= Artfactory.use( Punkxl::Sheet.builtin,
                                     image_class: Image )
    end
    def self.generate( *names )
      generator.generate( *names )
    end
  end # class Image


end #  module Punkxl


### add some convenience shortcuts / alternate spelling variants
PunkXL = Punkxl
PunkXl = Punkxl




###
# note: for convenience auto include Pixelart namespace!!! - why? why not?
include Pixelart



puts Pixelart::Module::Punks.banner    # say hello

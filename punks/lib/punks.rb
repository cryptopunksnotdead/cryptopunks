## 3rd party
require 'pixelart/base'
require 'backgrounds/base'
require 'artfactory'    ### todo/fix: change to artfactory/base


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
      @generator ||= Artfactory.use( Punkxl::Sheet.builtin )
    end
    def self.generate( *names )
      img =  generator.generate( *names )
       ## note: unwrap inner image before passing on to c'tor (requires ChunkyPNG image for now)
       new( 32, 32, img.image )
     end # method Image.generate
  end # class Image


end #  module Punkxl


### add some convenience shortcuts / alternate spelling variants
PunkXL = Punkxl
PunkXl = Punkxl




puts Pixelart::Module::Punks.banner    # say hello

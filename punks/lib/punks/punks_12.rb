

module Punk12

  class Spritesheet
    def self.builtin
      @builtin ||= Pixelart::Spritesheet.read(  "#{Pixelart::Module::Punks.root}/config/punks-12x12.png",
                                                "#{Pixelart::Module::Punks.root}/config/punks-12x12.csv",
                                                width:  12,
                                                height: 12 )
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
 
    NAMES = ['punk12', 'punks12', 
             'punkmini', 'punksmini',
             'punkxs', 'punksxs']
    DEFAULT_ATTRIBUTES = ['Pink Female']

    def self.generate( *names )
      base = Image.new( 12,12 )
   
      ## check for male/female gender
      gender = names[0].downcase.index( 'female' ) ? 'f' : 'm'
   
      names.each_with_index do |name,i|
           img = nil
           img = Sheet.find_by( name: "#{name} (#{gender})" )   if i > 0    ## try gender-specific first for accessores (not base e.g. i==0)
           img = Sheet.find_by( name:  name )    unless img       
           if img.nil?
              puts "!! attribute with key #{key} not found; sorry"
              exit 1
           end
           base.compose!( img )
      end
      base
    end
  end # class Image
end #  module Punk12




module Punk32

  class Spritesheet
    def self.builtin
      @builtin ||= Pixelart::SpritesheetEx.read( "#{Pixelart::Module::Punks.root}/config/punks-32x32.png",
                                                 "#{Pixelart::Module::Punks.root}/config/punks-32x32.csv",
                                                 width:  32,
                                                 height: 32 )
    end

    ## note: for now class used for "namespace" only
    def self.find_by( name:, gender: nil, size: nil, warn: true )  ## return archetype/attribute image by name
       # note: pass along name as q (query string)
       builtin.find_by( name: name,
                        gender: gender,
                        size:   size,
                        warn: warn )
    end
    def self.find_meta_by( name:, gender: nil, size: nil, warn: true )  ## return archetype/attribute image by name
      # note: pass along name as q (query string)
      builtin.find_meta_by( name: name,
                            gender: gender,
                            size:   size,
                            warn: warn )
   end
   def self.image() builtin.image; end

    ## helpers
    def self.normalize_key( str ) Pixelart::SpritesheetEx.normalize_key( str ); end
  end  # class Spritesheet


  ## add convenience (alternate spelling) alias - why? why not?
  SpriteSheet = Spritesheet
  Sheet       = Spritesheet
  Sprite      = Spritesheet



  class Image < Pixelart::Image

    def self.generate( *values, patch: nil )

      attributes = []   ## collect all attribute images (32x32, 24x24, etc.) to merge/paste here


      archetype_name  = values[0]

      if archetype_name.is_a?( Pixelart::Image )
        archetype = archetype_name
        attributes << archetype
        ### for now assume (support only)
         ##    large & male (l/m) for "inline/patch" archetypes - why? why not?
         ##    change male to unisex - why? why not?  (note: for now unisex is not doing a backup lookup using male/female)
         attribute_gender = 'm'
         attribute_size   = 'l'
     elsif patch && img=patch[ Sheet.normalize_key(archetype_name) ]
        archetype = img
        attributes << archetype
        if archetype_name.downcase.index( 'female' )
         ## note: attribute lookup requires gender from archetype!!!!
         ## quick & dirty hack for now
         ##    if name incl. female (automagically) switch to f(emale)/s(mall)
          attribute_gender = 'f'
          attribute_size   = 's'
        else
         attribute_gender = 'm'
         attribute_size   = 'l'
        end
     else ## assume it's a string
       ### todo/fix:  check for nil/not found!!!!
       ## todo/check/fix:  assert meta record returned is archetype NOT attribute!!!!
       archetype  = Sheet.find_meta_by( name: archetype_name )
       if archetype.nil?
         puts "!! ERROR -  archetype >#{archetype}< not found; sorry"
         exit 1
       end
       attributes << Sheet.image[ archetype.id ]
       attribute_gender = archetype.gender
       attribute_size   = archetype.size
     end

      attribute_names  = values[1..-1]
      attribute_names.each do |attribute_name|
         ## note: quick hack - allow "inline" raw images for now - why? why not?
         ##         pass through as-is
        if attribute_name.is_a?( Pixelart::Image )
          attributes << attribute_name
        elsif patch && img=patch[ Sheet.normalize_key(attribute_name) ]
          attributes << img
        else
          attribute = Sheet.find_by( name: attribute_name,
                                     gender: attribute_gender,
                                     size:   attribute_size,
                                     warn: false )
          ## try 24x24 punk attribute next
          attribute = Punk::Sheet.find_by( name: attribute_name,
                                           gender: attribute_gender,
                                           size:   attribute_size ) if attribute.nil?

          if attribute.nil?
            puts "!! ERROR - attribute >#{attribute_name}< for (#{attribute_gender}+#{attribute_size}) not found; sorry"
            exit 1
          end

          attributes << attribute
         end
      end

      punk = new( 32, 32 )

      attributes.each do |attribute|
        if attribute.width == 24 && attribute.height == 24
          ## cut-off top 1px (24x23)
          attribute =  attribute.crop( 0, 1, 24, 23 )
          ## offset x/y for classic 24x24 attributes in 40x40 canvas
          punk.compose!( attribute, 6, 0 )
        elsif attribute.width == 32 && attribute.height == 32
          punk.compose!( attribute )
        else
          puts "!! ERROR - unsupported attribute size; got #{attribute.width}x#{attribute.height} - expected 32x32 or 24x24; sorry"
          exit 1
        end
      end
      punk
    end # method Image.generate
  end # class Image
end # module Punk32


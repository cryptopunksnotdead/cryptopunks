

module Punk40

  class Spritesheet
    ## helpers
    def self.normalize_key( str ) Pixelart::SpritesheetEx.normalize_key( str ); end
  end  # class Spritesheet

  ## add convenience (alternate spelling) alias - why? why not?
  SpriteSheet = Spritesheet
  Sheet       = Spritesheet
  Sprite      = Spritesheet



  class Image < Pixelart::Image

    NAMES = ['punk40', 'punks40']
    DEFAULT_ATTRIBUTES = ['Male Mid 2']

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
        archetype  = Punk32::Sheet.find_meta_by( name: archetype_name )
        if archetype.nil?
          puts "!! ERROR -  archetype >#{archetype}< not found; sorry"
          exit 1
        end
        attributes << Punk32::Sheet.image[ archetype.id ]
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
          attribute = Punk32::Sheet.find_by( name: attribute_name,
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

      punk = new( 40, 40 )

      attributes.each do |attribute|
        offset = if attribute.width == 24 && attribute.height == 24
                    [6,7] ## offset x/y for classic 24x24 attributes in 40x40 canvas
                 elsif attribute.width == 32 && attribute.height == 32
                    [0,8]
                 elsif attribute.width == 40 && attribute.height == 40
                    [0,0]
                 else
                    puts "!! ERROR - unsupported attribute size; got #{attribute.width}x#{attribute.height} - expected 40x40, 32x32 or 24x24; sorry"
                    exit 1
                 end
        punk.compose!( attribute, *offset )
      end
      punk
    end # method Image.generate
  end # class Image
end # module Punk40


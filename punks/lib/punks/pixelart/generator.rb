
module Pixelart
  class GeneratorEx

    def self.read( image_path="./spritesheet.png",
                   meta_path="./spritesheet.csv",
                  width: 24,
                  height: 24,
                  image_class: Image )

      sheet = SpritesheetEx.read( image_path,
                                meta_path,
                                width: width, height: height )
      new( sheet, image_class: image_class )
    end

    def self.use( sheet, image_class: Image )    ### check - allow more sheets - why? why not?
      new( sheet, image_class: image_class )
    end



    def normalize_key( str )     SpritesheetEx.normalize_key( str ); end
    def normalize_gender( str )  SpritesheetEx.normalize_gender( str ); end
    def normalize_size( str )    SpritesheetEx.normalize_size( str ); end
    def normalize_name( str )    SpritesheetEx.normalize_name( str ); end


    def initialize( sheet, image_class: )
      @sheet       = sheet
      @image_class = image_class

      puts "  [punkfactory] using image class >#{@image_class.name}< for #{@sheet.image.tile_width}x#{@sheet.image.tile_height} images"
    end

    def spritesheet() @sheet; end
    alias_method  :sheet, :spritesheet


   def to_recs( *values, style: nil, patch: nil )

      recs = []

      archetype_name  = values[0]

      if archetype_name.is_a?( Image )
         archetype = archetype_name
         recs << archetype
           ### for now assume (support only)
           ##    large & male (l/m) for "inline/patch" archetypes - why? why not?
           ##    change male to unisex - why? why not?  (note: for now unisex is not doing a backup lookup using male/female)
           attribute_gender = 'm'
           attribute_size   = 'l'
      elsif patch && img=patch[ normalize_key(archetype_name) ]
         archetype = img
         recs << archetype
         if archetype_name.downcase.index( 'female' )
          ## note: attribute lookup requires gender from archetype!!!!
          ## quick & dirty hack for now
          ##    if name incl. female (automagically) switch to f(emale)/s(mall)
           attribute_gender = 'f'
           attribute_size   = 's'
         else
           ##    large & male (l/m) for "inline/patch" archetypes - why? why not?
           ##    change male to unisex - why? why not?  (note: for now unisex is not doing a backup lookup using male/female)
           attribute_gender = 'm'
           attribute_size   = 'l'
         end
      else ## assume it's a string
        ### todo/fix:  check for nil/not found!!!!
        ## todo/check/fix:  assert meta record returned is archetype NOT attribute!!!!
        archetype  = @sheet.find_meta_by( name: archetype_name )
        if archetype.nil?
          puts "!! ERROR -  archetype >#{archetype}< not found; sorry"
          exit 1
        end
        recs << archetype
        attribute_gender = archetype.gender
        attribute_size   = archetype.size
      end


      attribute_names  = values[1..-1]
      attribute_names.each do |attribute_name|
         ## note: quick hack - allow "inline" raw images for now - why? why not?
         ##         pass through as-is
        if attribute_name.is_a?( Image )
          recs << attribute_name
        elsif patch && img=patch[ normalize_key(attribute_name) ]
          recs << img
        else
          rec = @sheet.find_meta_by( name: attribute_name,
                                     gender: attribute_gender,
                                     size:   attribute_size,
                                     style:  style )
          if rec.nil?
            puts "!! ERROR - attribute >#{attribute_name}< for (#{attribute_gender}+#{attribute_size}) not found; sorry"
            exit 1
          end

          recs << rec
         end
      end

      recs
 end


 def generate_image( *values, style: nil, patch: nil )
   ## check: rename patch to more/extras/foreign or ... - why? why not?

    recs = to_recs( *values, style: style, patch: patch )

    punk = @image_class.new( @sheet.image.tile_width,
                             @sheet.image.tile_height  )

    recs.each do |rec|
      ## note: quick hack - allow "inline" raw images for now - why? why not?
      ##         pass through as-is
      img = if rec.is_a?( Image )
              rec
            else
              @sheet.image[ rec.id ]
            end
      punk.compose!( img )
    end

    punk
 end
 alias_method :generate, :generate_image

 end # class Generator

end # module Pixelart

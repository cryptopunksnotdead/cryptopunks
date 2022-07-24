
module Punk

  class Spritesheet
    def self.builtin
      @builtin ||= SpritesheetEx.read(  "#{Pixelart::Module::Punks.root}/config/punks-24x24.png",
                                        "#{Pixelart::Module::Punks.root}/config/punks-24x24.csv",
                                        width:  24,
                                        height: 24 )
    end

    ## note: for now class used for "namespace" only
    def self.find_by( name:, gender: nil, size: nil, warn: true )  ## return archetype/attribute image by name
       # note: pass along name as q (query string)
       builtin.find_by( name: name,
                        gender: gender,
                        size:   size,
                        warn:   warn )
    end
    def self.find( name, gender: nil, size: nil )  ## return archetype/attribute image by name
      puts "!!! [WARN] deprecated method call Punk::Spritesheet.find use find_by( name: ) !!!!"
      builtin.find_by( name: name,
                       gender: gender,
                       size:   size )
    end
    ## helpers
    def self.normalize_key( str ) Pixelart::SpritesheetEx.normalize_key( str ); end
 end  # class Spritesheet


  ## add convenience (alternate spelling) alias - why? why not?
  SpriteSheet = Spritesheet
  Sheet       = Spritesheet
  Sprite      = Spritesheet



  class Image < Pixelart::Image
    def self.generator
      @generator ||= GeneratorEx.use( Sheet.builtin, image_class: Image )
    end

    def self.generate( *values, style: nil, patch: nil )

     if values[0].is_a?( String )
       #####  add style option / hack - why? why not?
       if style
         values =  if style.downcase.index( 'natural') && style.downcase.index( '2')
                     ["#{values[0]} (N2)"] + values[1..-1]
                   elsif style.downcase[0] == 'n'  ## starting with n - always assume natural(s)
                    ## auto-add (N) for Natural to archetype
                     ["#{values[0]} (N)"] + values[1..-1]
                   else
                     puts "!! ERROR - unknown punk style #{style}; sorry"
                     exit 1
                   end
       end

     ###### hack for black&white
     ##   auto-add b&w (black&white) to all attribute names e.g.
     ##      Eyes   =>  Eyes B&W
     ##      Smile  =>  Smile B&W
     ##      ....
      archetype_key =  Sheet.normalize_key( values[0] )
       if archetype_key.end_with?( 'bw' ) ||  ## e.g. B&W
          archetype_key.end_with?( '1bit')    ## e.g. 1-Bit or 1Bit

          values = [values[0]] + values[1..-1].map do |attribute|
             if attribute.is_a?( Pixelart::Image )
                attribute
             else
                attribute_key = Sheet.normalize_key( attribute )
                if ['wildhair'].include?( attribute_key )   ## pass through known b&w attributes by "default"
                   attribute
                elsif attribute_key.index( "black" )
                   attribute ## pass through as-is
                else
                  "#{attribute} B&W"
                end
             end
         end

         pp values
      end

    # note: female mouth by default has "custom" colors (not black)
    #          for every 1/2/3/4 (human) skin tone and for zombie
    #   auto-"magically" add mapping
    #
    #  todo/check/fix - add more "contraints"
    #    for mapping to only kick-in for "basic" versions
    #      and not "colored" e.g. golden and such - why? why not?
    #
    #    move this mapping here to "post-lookup" processing
    #   to get/incl. more "meta" attribute info  - why? why not?
    if archetype_key.index( 'female1' ) ||
       archetype_key.index( 'female2' ) ||
       archetype_key.index( 'female3' ) ||
       archetype_key.index( 'female4' ) ||
       archetype_key.index( 'zombiefemale' )

      values = [values[0]] + values[1..-1].map do |attribute|
        if attribute.is_a?( Pixelart::Image )
          attribute
        else
          attribute_key = Sheet.normalize_key( attribute )

          if attribute_key == 'smile' || attribute_key == 'frown'
             attribute +=   if    archetype_key.index( 'zombiefemale' ) then ' Zombie'
                            elsif archetype_key.index( 'female1' )      then ' 1'
                            elsif archetype_key.index( 'female2' )      then ' 2'
                            elsif archetype_key.index( 'female3' )      then ' 3'
                            elsif archetype_key.index( 'female4' )      then ' 4'
                            else
                              puts "!! ERROR - smile or frown (mouth expression) not supported for archetype:"
                              pp values
                              exit 1
                            end
           end
           attribute
        end
      end
    end
   end

       generator.generate( *values, style: style, patch: patch )
     end # method Image.generate
  end # class Image
end #  module Punk



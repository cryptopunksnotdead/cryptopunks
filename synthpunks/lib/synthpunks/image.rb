
module Synthpunks


class Image < Pixelart::Image
    def self.generate( addr )
      puts "==> generate SyntheticPunk for #{addr}..."
       token_id = Synthpunks.getTokenID( addr )
       ## note: MUST sort for correct rendering order
       puts "    using (derived) token_id >#{token_id}<"
       attributes = Synthpunks.getAttributes( token_id ).sort
       puts "    using (pseudo-random derived) attributes >#{attributes}<:"
       attributes.each do |attribute|
           puts "       #{attribute} => #{SPRITESHEET_ATTRIBUTES[attribute]}"
       end

       img = new( 24, 24 )
       attributes.each do |attribute|
          img.compose!( SPRITESHEET[ attribute ] )
       end
       img
    end
end  # class Image
end   # module Synthpunks


module Phunk

  class Image < Pixelart::Image

    def self.generate( *values, style: nil )
        punk = Punk::Image.generate( *values, style: style )
        phunk = punk.mirror

        ## wrap in Phunks class (note: use/ requires inner image)
        new( phunk.width, phunk.height, phunk.image )
    end
  end # class Image
end  # module Phunk
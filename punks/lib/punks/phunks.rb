
module Phunk

  class Image < Pixelart::Image

    NAMES = ['phunk', 'phunks']
    DEFAULT_ATTRIBUTES = ['Male 2']

    def self.generate( *values, style: nil )
        punk = Punk::Image.generate( *values, style: style )
        phunk = punk.mirror

        ## wrap in Phunks class (note: use/ requires inner image)
        new( phunk.width, phunk.height, phunk.image )
    end
  end # class Image
end  # module Phunk
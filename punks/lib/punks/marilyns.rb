

module Marilyn

  class Image < Pixelart::Image

    MARILYN_ATTRIBUTES = ['Female 3', 'Wild Blonde', 'Mole',
                          'Blue Eye Shadow']

    NAMES = ['marilyn', 'marilyns']

    def self.generate( *values, style: nil )
        punk = Punk::Image.generate( *MARILYN_ATTRIBUTES,
                                     *values, style: style )
        phunk = punk.mirror

        ## wrap in Marilyn class (note: use/ requires inner image)
        new( phunk.width, phunk.height, phunk.image )
    end
  end # class Image
end  # module Marilyn


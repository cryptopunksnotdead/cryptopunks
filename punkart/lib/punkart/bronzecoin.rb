
module Pixelart
module Bronzecoin

  def self.mint( img )
    raise ArgumentError, "sorry only 24x24 supported for now; called on image #{img.width}x#{img.height}"  unless img.width == 24 && img.height == 24

    ## change to coin color palette
    coin = Image.new( 32, 32 )
    coin.compose!( COIN_FRAME )
    coin.compose!( img.change_palette8bit( COIN_PALETTE ), 5, 3 )
    coin
  end

####
#  helpers
COIN_FRAME         = Image.read( "#{Module::Punkart.root}/config/bronzecoin.png" )

# note: use dark to light
COIN_PALETTE = Gradient.new( '#7C433A',
                             '#8D5144',
                             '#B16C57',
                             '#C87E63',
                             '#E99775' ).colors( 256 )


def self.frame()  COIN_FRAME; end
def self.width()  COIN_FRAME.width; end
def self.height() COIN_FRAME.height; end
def self.palette() COIN_PALETTE; end

end # module Bronzecoin
end # module Pixelart
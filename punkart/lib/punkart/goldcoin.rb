
module Pixelart
module Goldcoin

  def self.mint( img )
    raise ArgumentError, "sorry only 24x24 supported for now; called on image #{img.width}x#{img.height}"  unless img.width == 24 && img.height == 24

    ## change to coin color palette
    coin = Image.new( 32, 32 )
    coin.compose!( COIN_FRAME_BACK )
    coin.compose!( img.change_palette8bit( COIN_PALETTE ), 5, 3 )
    coin.compose!( COIN_FRAME_FRONT )
    coin
  end

####
#  helpers
COIN_FRAME         = Image.read( "#{Module::Punkart.root}/config/goldcoin.png" )
COIN_FRAME_FRONT   = Image.read( "#{Module::Punkart.root}/config/goldcoin-front.png" )
COIN_FRAME_BACK    = Image.read( "#{Module::Punkart.root}/config/goldcoin-back.png" )

# note: use dark to light
COIN_PALETTE = Gradient.new( '#CA7128',
                             '#D9862C',
                             '#F2AF39',
                             '#F6C451',
                             '#FBE272' ).colors( 256 )


def self.frame()  COIN_FRAME; end
def self.width()  COIN_FRAME.width; end
def self.height() COIN_FRAME.height; end
def self.palette() COIN_PALETTE; end

end # module Goldcoin
end # module Pixelart
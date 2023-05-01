
module Pixelart
module Silvercoin

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
COIN_FRAME         = Image.read( "#{Module::Punkart.root}/config/silvercoin.png" )

# note: use dark to light
COIN_PALETTE = Gradient.new( '#4F5865',
                             '#636C78',
                             '#8B949E',
                             '#A5AEB6',
                             '#CAD3D9' ).colors( 256 )


def self.frame()  COIN_FRAME; end
def self.width()  COIN_FRAME.width; end
def self.height() COIN_FRAME.height; end
def self.palette() COIN_PALETTE; end

end # module Silvercoin
end # module Pixelart
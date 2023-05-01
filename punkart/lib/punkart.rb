require 'pixelart'

## auto-requre punks and punkmaker - why? why not?
require 'punks'
require 'punkmaker'



## our own code
require_relative 'punkart/version'   # let versoin go first
require_relative 'punkart/dollar'
require_relative 'punkart/goldcoin'
require_relative 'punkart/silvercoin'
require_relative 'punkart/bronzecoin'


module Pixelart
class Image


def greenback() Dollar.print( self ); end
alias_method :dollar,    :greenback
alias_method :dollarize, :greenback

def goldcoin()  Goldcoin.mint( self ); end
def silvercoin()  Silvercoin.mint( self ); end
def bronzecoin()  Bronzecoin.mint( self ); end


end # class Image
end # module Pixelart




puts Pixelart::Module::Punkart.banner    # say hello


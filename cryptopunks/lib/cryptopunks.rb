## 3rd party
require 'punks'



## extra stdlibs
require 'digest'     ## move/add to pixelart upstream - why? why not?
require 'optparse'
require 'cmdparse'        ## used for command line tool



## our own code
require 'cryptopunks/version'    # note: let version always go first


require 'cryptopunks/attributes'
require 'cryptopunks/colors'


####
# add CryptoPunksData (off-chain) contract
require 'cryptopunks/contract/punksdata-assets'
require 'cryptopunks/contract/punksdata-meta'
require 'cryptopunks/contract/punksdata-contract'
CryptoPunksData = CryptopunksData
PunksData       = CryptopunksData





require 'cryptopunks/tool'

### add tool convenience helper
module Punk
  def self.main( args=ARGV ) Tool.new.run( args ); end
end ## module Punk





###
# note: for convenience auto include Pixelart namespace!!! - why? why not?
include Pixelart



puts Pixelart::Module::Cryptopunks.banner    # say hello

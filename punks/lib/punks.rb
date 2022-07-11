## 3rd party
require 'pixelart/base'
require 'backgrounds/base'
require 'artfactory/base'


## our own code
require 'punks/version'    # note: let version always go first

require 'punks/generator'


## --- 24x24 series
require 'punks/punks'
require 'punks/phunks'
require 'punks/marilyns'
require 'punks/philips'
require 'punks/saudis'
## --- 32x32 series
require 'punks/punks_xl'





### add some convenience shortcuts
Cryptopunks = Punk
CryptoPunks = Punk
Punks       = Punk
## add singular too -why? why not?
Cryptopunk  = Punk
CryptoPunk  = Punk


### add some convenience shortcuts / alternate spelling variants
PunkXL = Punkxl
PunkXl = Punkxl

### add some convenience shortcuts / alternate spelling variants
Phunks  = Phunk

### add some convenience shortcuts / alternate spelling variants
Philips = Philip

### add some convenience shortcuts / alternate spelling variants
Marilyns = Marilyn

### add some convenience shortcuts / alternate spelling variants
Saudis   = Saudi
Sheiks   = Saudi
Sheik    = Saudi


###
# note: for convenience auto include Pixelart namespace!!! - why? why not?
include Pixelart



puts Pixelart::Module::Punks.banner    # say hello

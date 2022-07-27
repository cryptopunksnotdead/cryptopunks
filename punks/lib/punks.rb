## 3rd party
require 'pixelart/base'
require 'backgrounds/base'
require 'artfactory/base'


## our own code
require 'punks/version'    # note: let version always go first


require 'punks/pixelart/spritesheet'
require 'punks/pixelart/generator'


## --- 24x24 series
require 'punks/punks'
require 'punks/phunks'
require 'punks/marilyns'
require 'punks/philips'
require 'punks/saudis'
require 'punks/ye_olde_punks_2017'
## --- 32x32 series
require 'punks/punks_xl'
require 'punks/bodies_32'
## --- 40x40 series
require 'punks/bodies_40'




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


## add some convience shortcuts / alternate spelling variants
YeOldePunk2017 = YeOldePunkAnno2017
Yeoldepunk2017 = YeOldePunkAnno2017
YeOldePunk     = YeOldePunkAnno2017
Yeoldepunk     = YeOldePunkAnno2017
Punk2017   = YeOldePunkAnno2017
PunkV1     = YeOldePunkAnno2017
Punkv1     = YeOldePunkAnno2017
PunkV2     = YeOldePunkAnno2017
Punkv2     = YeOldePunkAnno2017


###
# note: for convenience auto include Pixelart namespace!!! - why? why not?
include Pixelart



puts Pixelart::Module::Punks.banner    # say hello

## 3rd party
require 'pixelart/base'
require 'backgrounds/base'
require 'artfactory/base'


## our own code
require_relative 'punks/version'    # note: let version always go first


require_relative 'punks/pixelart/spritesheet'
require_relative 'punks/pixelart/generator'


## --- 24x24 series
require_relative 'punks/punks'
require_relative 'punks/phunks'
require_relative 'punks/marilyns'
require_relative 'punks/philips'
require_relative 'punks/saudis'
require_relative 'punks/marcs'
require_relative 'punks/ye_olde_punks_2017'
## --- 32x32 series
require_relative 'punks/punks_xl'
require_relative 'punks/bodies_32'
## --- 40x40 series
require_relative 'punks/bodies_40'
## --- 12x12 series
require_relative 'punks/punks_12'

## more 
require_relative 'punks/nodepunks'   # 24x24


## extra/bonus  - add dataset (csv reader) with metadata struct
require_relative 'punks/dataset/dataset'




### add some convenience shortcuts
Cryptopunks = Punk
CryptoPunks = Punk
Punks       = Punk
## add singular too -why? why not?
Cryptopunk  = Punk
CryptoPunk  = Punk

### add some convenience shortcuts / alternate spelling variants
PunkXS   = Punk12 
PunkXs   = Punk12
PunkMini = Punk12
Punkmini = Punk12
MiniPunk = Punk12
Minipunk = Punk12


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


## add Node too as alias - why? why not?
NodePunk   = Nodepunk
NodePunks  = Nodepunk
Nodepunks  = Nodepunk



###
# note: for convenience auto include Pixelart namespace!!! - why? why not?
include Pixelart



puts Pixelart::Module::Punks.banner    # say hello

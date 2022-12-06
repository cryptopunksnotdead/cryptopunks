require 'pixelart'
require 'ethlite'     ## needed for Digest::Keccak (otherwise no dep for now)


## our own code
require_relative 'synthpunks/version'
require_relative 'synthpunks/contract'
require_relative 'synthpunks/image'



## add some alternate names / aliases - why? why not?
Synthpunk      = Synthpunks
Syntheticpunk  = Synthpunks
Syntheticpunks = Synthpunks
SynthPunk      = Synthpunks
SynthPunks     = Synthpunks
SyntheticPunk  = Synthpunks
SyntheticPunks = Synthpunks


puts Pixelart::Module::Synthpunks.banner   # say hello
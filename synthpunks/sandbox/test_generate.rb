###
#  to run use
#     ruby -I ./lib sandbox/test_generate.rb


require 'synthpunks'


punk = Synthpunks::Image.generate( '0x054f3b6eadc9631ccd60246054fdb0fcfe99b322' )
punk.save( "./tmp/punk1.png" )
punk.zoom(8).save( "./tmp/punk1@8x.png" )

punk = Synthpunks::Image.generate( '0x7a80ee32044f496a7bfef65af738fdda3a02cf02' )
punk.save( "./tmp/punk2.png" )
punk.zoom(8).save( "./tmp/punk2@8x.png" )


pp Synthpunks.getAttributeNames( 30311890011735557186986086868537068337617285922 )
pp Synthpunks.getAttributeNames( 699372119169819039191610289391678040975564001026 )

puts "bye"

###
#  to run use
#     ruby -I ./lib sandbox/test_generate.rb


require 'synthpunks'


punk = Synthpunks::Image.generate( '0x054f3b6eadc9631ccd60246054fdb0fcfe99b322' )
punk.save( "./tmp/punk1.png" )
punk.zoom(8).save( "./tmp/punk1@8x.png" )

base = punk
punk = base.background( '#1A1A1A' )
punk.save( "./tmp/punk1b.png" )
punk.zoom(8).save( "./tmp/punk1b@8x.png" )

punk = base.background( 'ukraine' )
punk.save( "./tmp/punk1c.png" )
punk.zoom(8).save( "./tmp/punk1c@8x.png" )

punk = base.background( 'rainbow' )
punk.save( "./tmp/punk1d.png" )
punk.zoom(8).save( "./tmp/punk1d@8x.png" )

phunk = base.mirror
phunk.save( "./tmp/phunk1.png" )
phunk.zoom(8).save( "./tmp/phunk1@8x.png" )


punk = base.silhouette( '0x647785' ).background( '0xCCD5DE' )
punk.save( './tmp/punk1-default1.png' )
punk.zoom(8).save( './tmp/punk1-default1@8x.png' )

punk = base.silhouette( '0x4474E0' ).background( '0xA0C2FF' )
punk.save( './tmp/punk1-default2.png' )
punk.zoom(8).save( './tmp/punk1-default2@8x.png' )



punk = Synthpunks::Image.generate( '0x7a80ee32044f496a7bfef65af738fdda3a02cf02' )
punk.save( "./tmp/punk2.png" )
punk.zoom(8).save( "./tmp/punk2@8x.png" )


pp Synthpunks.getAttributeNames( 30311890011735557186986086868537068337617285922 )
pp Synthpunks.getAttributeNames( 699372119169819039191610289391678040975564001026 )

puts "bye"

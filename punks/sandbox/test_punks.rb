###
#  to run use
#     ruby -I ./lib sandbox/test_punks.rb


require 'punks'


punks = Csv.parse( <<TXT )
  Female 1
  Female 2
  Female 3
  Male 1
  Male 2
  Male 3
  Female 2, Blonde Bob, Green Eye Shadow, Hot Lipstick
  Male 1, Mohawk
  Female 3, Wild Hair, Hot Lipstick
  Male 1, Wild Hair, Nerd Glasses, Pipe
  Male 2, Goat, Earring, Wild Hair, Big Shades
  Female 2, Earring, Purple Eye Shadow, Half Shaved, Hot Lipstick

  Zombie
  Zombie, Crazy Hair, Earring
  Zombie, Bandana, Eye Patch, Earring
  Zombie, Knitted Cap
  Zombie, Top Hat, Nerd Glasses, Cigarette
  Zombie, Wild Hair, 3D Glasses, Smile
  Zombie, Headband, Goat
  Zombie, Cap Forward, Small Shades, Pipe
  Zombie, Beanie, Smile
  Zombie, Hoodie

  Ape
  Ape, Headband
  Ape, Cap Forward, Earring
  Ape, Knitted Cap
  Ape, Knitted Cap, Small Shades
  Ape, Top Hat, Small Shades
  Ape, Cowboy Hat, 3D Glasses
  Ape, Hoodie

  Alien
  Alien, Knitted Cap, Earring
  Alien, Knitted Cap, Earring, Medical Mask
  Alien, Headband
  Alien, Cap Forward, Small Shades, Pipe
TXT


punks.each_with_index do |attributes, i|
  base = Punk::Image.generate( *attributes )

  punk = base
  punk.save( "./tmp/punk#{i}.png" )
  punk.zoom(4).save( "./tmp/punk#{i}@4x.png" )

  punk = base.background( 'Matrix 1' )
  punk.save( "./tmp/punk#{i}b.png" )
  punk.zoom(8).save( "./tmp/punk#{i}b@8x.png" )

  punk = base.background( 'Ukraine' )
  punk.save( "./tmp/punk#{i}c.png" )
  punk.zoom(4).save( "./tmp/punk#{i}c@4x.png" )
end



####################
### try (left-looking) phunks
punks.each_with_index do |attributes, i|
  base = Phunk::Image.generate( *attributes )

  punk = base
  punk.save( "./tmp/phunk#{i}.png" )
  punk.zoom(4).save( "./tmp/phunk#{i}@4x.png" )

  punk = base.background( 'Matrix 1' )
  punk.save( "./tmp/phunk#{i}b.png" )
  punk.zoom(8).save( "./tmp/phunk#{i}b@8x.png" )

  punk = base.background( 'Ukraine' )
  punk.save( "./tmp/phunk#{i}c.png" )
  punk.zoom(4).save( "./tmp/phunk#{i}c@4x.png" )
end


### try with inline image and "patch" lookup


INVISIBLE   = Pixelart::Image.new( 24, 24 )

CHOKER      = Pixelart::Image.read( "../../punks.blocks/basic/m/choker.png" )
CHOKER2     = Pixelart::Image.read( "../../punks.blocks/basic/m/choker2.png" )
TASSLE_HAT  = Pixelart::Image.read( "../../punks.blocks/basic/m/tasslehat.png" )
TASSLE_HAT2 = Pixelart::Image.read( "../../punks.blocks/basic/m/tasslehat2.png" )

punk = Punk::Image.generate( "Male 3", CHOKER2, TASSLE_HAT, "3D Glasses" )
punk.zoom( 4 ).save( "./tmp/punk_inline1a@4x.png" )

punk = Punk::Image.generate( INVISIBLE, CHOKER, TASSLE_HAT2, "Pipe" )
punk.zoom( 4 ).save( "./tmp/punk_inline1b@4x.png" )


patch = { 'invisible' => INVISIBLE,
          'choker'   => CHOKER,
          'choker2'   => CHOKER2,
          'tasslehat' => TASSLE_HAT,
          'tasslehat2' => TASSLE_HAT2,
         }
punk = Punk::Image.generate( "Male 1", "Choker 2", "Tassle Hat", "3D Glasses",
                                patch: patch )
punk.zoom( 4 ).save( "./tmp/punk_patch1a@4x.png" )

punk = Punk::Image.generate( "Invisible", "Choker", "Tassle Hat 2", "Pipe",
                                patch: patch )
punk.zoom( 4 ).save( "./tmp/punk_patch1b@4x.png" )



puts "bye"

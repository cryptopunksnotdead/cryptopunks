###
#  to run use
#     ruby -I ./lib sandbox/test_philips.rb


require 'punks'


philips = Csv.parse( <<TXT )
  Nerd Glasses, Pipe
  Goat, Earring, Big Shades
  Earring
  Bandana, Eye Patch, Earring
  Knitted Cap
  Knitted Cap, Small Shades
  Knitted Cap, Earring, Medical Mask
  Top Hat, Nerd Glasses, Cigarette
  Top Hat, Small Shades
  3D Glasses, Smile
  Headband, Goat
  Headband
  Cap Forward, Small Shades, Pipe
  Cap Forward, Earring
  Cowboy Hat, 3D Glasses
  Beanie, Smile
  Hoodie
TXT


([[]] + philips).each_with_index do |attributes, i|
  base = Philip::Image.generate( *attributes )

  punk = base
  punk.save( "./tmp3/philip#{i}.png" )
  punk.zoom(4).save( "./tmp3/philip#{i}@4x.png" )

  punk = base.background( 'Matrix 2' )
  punk.save( "./tmp3/philip#{i}b.png" )
  punk.zoom(8).save( "./tmp3/philip#{i}b@8x.png" )

  punk = base.background( 'Ukraine' )
  punk.save( "./tmp3/philip#{i}c.png" )
  punk.zoom(8).save( "./tmp3/philip#{i}c@8x.png" )
end



puts "bye"

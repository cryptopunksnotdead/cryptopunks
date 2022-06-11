###
#  to run use
#     ruby -I ./lib sandbox/test_marilyns.rb


require 'punks'


marilyns = Csv.parse( <<TXT )
  Smile
  3D Glasses
  Flowers, Earring, Smile
  Hot Lipstick, Big Shades
  Beanie, Smile
TXT


([[]] + marilyns).each_with_index do |attributes, i|
  base = Marilyn::Image.generate( *attributes )

  punk = base
  punk.save( "./tmp2/marilyn#{i}.png" )
  punk.zoom(4).save( "./tmp2/marilyn#{i}@4x.png" )

  punk = base.background( 'Matrix 2' )
  punk.save( "./tmp2/marilyn#{i}b.png" )
  punk.zoom(8).save( "./tmp2/marilyn#{i}b@8x.png" )

  punk = base.background( 'Ukraine' )
  punk.save( "./tmp2/marilyn#{i}c.png" )
  punk.zoom(8).save( "./tmp2/marilyn#{i}c@8x.png" )
end


puts "bye"

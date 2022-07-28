###
#  to run use
#     ruby -I ./lib sandbox/test_marcs.rb


require 'punks'


marcs = Csv.parse( <<TXT )
  Marc
  Marc Classic
  Ape
  Ape Classic
  Marc Gold
  Marc Dark
  Marc Albino
  Marc Mid
  Devil
  Mad Lad
  Skeleton
  Ape Pink
  Alien
  Alien Green

  Marc, Normal Beard Black, Rosy Cheeks, Shine, Fast Food, Fast Food Shirt
  Marc, Marc Three
  Marc, Blue Eyes
  Marc, Green Eyes
  Marc, Spots
  Ape Gold, Blue Eyes
TXT


marcs.each_with_index do |attributes, i|
  base = Marc::Image.generate( *attributes )

  punk = base
  punk.save( "./tmpa16z/marc#{i}.png" )
  punk.zoom(4).save( "./tmpa16z/marc#{i}@4x.png" )

  punk = base.background( 'Matrix 2' )
  punk.save( "./tmpa16z/marc#{i}b.png" )
  punk.zoom(8).save( "./tmpa16z/marc#{i}b@8x.png" )

  punk = base.background( 'Ukraine' )
  punk.save( "./tmpa16z/marc#{i}c.png" )
  punk.zoom(8).save( "./tmpa16z/marc#{i}c@8x.png" )
end



puts "bye"

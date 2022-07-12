###
#  to run use
#     ruby -I ./lib sandbox/test_saudis.rb


require 'punks'


punks = Csv.parse( <<TXT )
  Male 01
  Male 02

  Male 03, Normal Brown Beard & Mustache,  Red Shemagh & Agal, Regular Pixel Shades
  Male 04, Messy White Beard,   Brown Shemagh & Agal, Big Purple Shades
  Male 05, Red Shemagh,  Nerd Glasses, Shadowless Cigarette
  Male 06, Short White Beard, Red Shemagh & Agal, Stylish Nerd Glasses
  Male 07, Normal Brown Beard & Mustache, White Shemagh & Agal
  Male 08, Stylish Mustache, Red Shemagh
  Male 09, Clean Shaven, Red Shemagh, None, None


  Dark 1, Stylish Mustache, White Shemagh & Gold Agal, MAX BIDDING, Rosewood Pipe

  Light 1, Normal Brown Beard & Mustache,  Red Shemagh & Agal, Regular Pixel Shades
  Light 1, Messy White Beard,   Brown Shemagh & Agal, Big Purple Shades
  Light 1, Red Shemagh,  Nerd Glasses, Shadowless Cigarette
  Light 2, Short White Beard, Red Shemagh & Agal, Stylish Nerd Glasses
  Light 2, Normal Brown Beard & Mustache, White Shemagh & Agal
  Dark 2,  Stylish Mustache, Red Shemagh
TXT


punks.each_with_index do |attributes, i|
  base = Saudi::Image.generate( *attributes )

  punk = base
  punk.save( "./tmp5/saudi#{i}.png" )
  punk.zoom(4).save( "./tmp5/saudi#{i}@4x.png" )

  punk = base.background( 'Ukraine' )
  punk.save( "./tmp5/saudi#{i}b.png" )
  punk.zoom(8).save( "./tmp5/saudi#{i}b@8x.png" )

  punk = base.background( 'Matrix 1' )
  punk.save( "./tmp5/saudi#{i}c.png" )
  punk.zoom(4).save( "./tmp5/saudi#{i}c@4x.png" )
end



puts "bye"

#################################
# to run use:
#
#  $ ruby sandbox/dollar.rb

$LOAD_PATH.unshift( "./lib" )
require 'punkart'



img = ImagePalette8bit.new( Dollar::DOLLAR_PALETTE, size: 4 )
img.save( "./tmp/palette_dollar.png" )
img.zoom(2).save( "tmp/palette_dollarx2.png" )



##
# generate dollar / greenback punks

specs = [
  ['Robot Male', 'Big Beard'],
  ['Human Male 2', 'Birthday Hat', 'Bubble Gum'],
  ['Human Female 1', 'Dark Hair', 'Flowers', 'Frown', 'Gold Chain'],
  ['Demon Male',     'Hoodie', 'Pipe'],
  ['Ape Male Blue',  'Bandana', 'Earring'],
  ['Human Male 3',  'Cowboy Hat', 'Smile', 'Laser Eyes'],
]

specs.each_with_index do |attributes, i|
   punk = Punk::Image.generate( *attributes )
   punk.save( "./tmp/punk-#{i+1}.png" )
   punk.zoom(4).save( "./tmp/punk-#{i+1}@4x.png" )

   dollar = punk.greenback  ## turn into greenback dollar
   dollar.save( "./tmp/dollar-#{i+1}.png" )
   dollar.zoom(4).save( "./tmp/dollar-#{i+1}@4x.png" )
end


puts "bye"
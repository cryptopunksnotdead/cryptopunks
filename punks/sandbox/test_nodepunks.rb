###
#  to run use
#     ruby -I ./lib sandbox/test_nodepunks.rb


require 'punks'


specs = parse_data( <<TXT )
  maxibiz, chinstrap, tophat, goldchain
  black, bob, lasereyes2 red
  default, capforward, earring, polarizedshades
  dark, chinstrap light, wizardhat, earring, lasereyes3 green
  light, chinstrap, cowboyhat, vr
  albino, headband, lasereyes3 green
  orange, mohawk2 blonde, clowneyes, clownnose
  zombie, mohawk purple
  orc, chinstrap light, wildhair red, classicshades
  alien, bandana, eyemask
  pink, bob blonde, headband, earring
TXT


specs.each_with_index do |attributes, i|
  punk = Nodepunk::Image.generate( *attributes )
  punk.save( "./tmp2/node/punk#{i}.png" )
  punk.zoom(4).save( "./tmp2/node/punk#{i}@4x.png" )
end


puts "bye"

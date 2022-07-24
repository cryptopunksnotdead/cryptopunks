###
#  to run use
#     ruby -I ./lib sandbox/test_punks_32px.rb


require 'punks'


punks = Csv.parse( <<TXT )
  Female 1
  Female 1A
  Female 2
  Female 3
  Female 3A
  Female Big 1
  Female Big 2
  Female Big 3
  Male 1
  Male 2
  Male 3
  Male Mid 1
  Male Mid 2
  Male Mid 3



  Female 2, Blonde Bob, Green Eye Shadow, Hot Lipstick
  Male 1, Mohawk
  Female 3, Wild Hair, Hot Lipstick
  Male 1, Wild Hair, Nerd Glasses, Pipe
  Male 2, Goat, Earring, Wild Hair, Big Shades
  Female 2, Earring, Purple Eye Shadow, Half Shaved, Hot Lipstick

  Zombie Female, Blonde Bob, Bubble Gum
  Zombie Female Big, Blonde Bob, Bubble Gum
  Ape Female, Blonde Bob, Bubble Gum
  Ape Female Big, Blonde Bob, Bubble Gum
  Alien Female,  Blonde Bob, Bubble Gum
  Alien Female Big,  Blonde Bob, Bubble Gum

  Zombie, Crazy Hair, Bubble Gum
  Ape,   Crazy Hair, Bubble Gum
  Alien, Crazy Hair, Bubble Gum
  Alien, Cap Forward, Small Shades, Pipe
TXT


punks.each_with_index do |attributes, i|
  base = Punk32::Image.generate( *attributes )

  punk = base
  punk.save( "./tmp/32px/punk#{i}.png" )
  punk.zoom(4).save( "./tmp/32px/punk#{i}@4x.png" )
end


puts "bye"

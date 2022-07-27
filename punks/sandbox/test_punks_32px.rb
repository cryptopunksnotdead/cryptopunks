###
#  to run use
#     ruby -I ./lib sandbox/test_punks_32px.rb


require 'punks'


punks = Csv.parse( <<TXT )
  Female L 1
  Female L 1A
  Female L 2
  Female L 3
  Female L 3A
  Female XXL 1
  Female XXL 2
  Female XXL 3
  Male XS 1
  Male XS 2
  Male XS 3
  Male Mid 1
  Male Mid 2
  Male Mid 3



  Female Mid 2, Blonde Bob, Green Eye Shadow, Hot Lipstick
  Male Mid 1, Mohawk
  Female Mid 3, Wild Hair, Hot Lipstick
  Male Mid 1, Wild Hair, Nerd Glasses, Pipe
  Male Mid 2, Goat, Earring, Wild Hair, Big Shades
  Female Mid 2, Earring, Purple Eye Shadow, Half Shaved, Hot Lipstick

  Zombie Female L, Blonde Bob, Bubble Gum
  Zombie Female XXL, Blonde Bob, Bubble Gum
  Ape Female L, Blonde Bob, Bubble Gum
  Ape Female XXL, Blonde Bob, Bubble Gum
  Alien Female L,  Blonde Bob, Bubble Gum
  Alien Female XXL,  Blonde Bob, Bubble Gum

  Zombie Mid, Crazy Hair, Bubble Gum
  Ape Mid,   Crazy Hair, Bubble Gum
  Alien Mid, Crazy Hair, Bubble Gum
  Alien Mid, Cap Forward, Small Shades, Pipe
TXT


punks.each_with_index do |attributes, i|
  base = Punk32::Image.generate( *attributes )

  punk = base
  punk.save( "./tmp/32px/punk#{i}.png" )
  punk.zoom(4).save( "./tmp/32px/punk#{i}@4x.png" )
end


puts "bye"

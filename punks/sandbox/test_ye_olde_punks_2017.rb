###
#  to run use
#     ruby -I ./lib sandbox/test_ye_olde_punks_2017.rb


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

  Bot
  Bot Female
  Bot,  Antenna
  Bot Female, Antenna

  Male Mid, Blonde Short
  Male Dark, Orange Side
  Female Mid, Hoodie
  Female Dark, Cowboy Hat
TXT


punks.each_with_index do |attributes, i|
  base = YeOldePunk2017::Image.generate( *attributes )

  punk = base
  punk.save( "./tmp2017/punk#{i}.png" )
  punk.zoom(4).save( "./tmp2017/punk#{i}@4x.png" )

  punk = base.background( 'Matrix 1' )
  punk.save( "./tmp2017/punk#{i}b.png" )
  punk.zoom(8).save( "./tmp2017/punk#{i}b@8x.png" )

  punk = base.background( 'Ukraine' )
  punk.save( "./tmp2017/punk#{i}c.png" )
  punk.zoom(8).save( "./tmp2017/punk#{i}c@8x.png" )
end


puts "bye"

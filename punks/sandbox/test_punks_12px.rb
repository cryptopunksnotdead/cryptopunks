###
#  to run use
#     ruby -I ./lib sandbox/test_punks_12px.rb


require 'punks'


specs = parse_data( <<TXT )
   bot, big beard   #1
   demon, hoodie, pipe  #4

   female3, mole, choker, wild white hair,  big shades, cigarette   #10 

     zombie, mole, 3d glasses, big beard, earring #11  
     orc, beanie, vr, clown nose   # 12

    demon, cigarette, laser eyes  # 17

    alien gold, top hat, silver chain # 21

    blue, clown hair blue  # 22 

    skeleton, eye patch, fedora  #35
 
    orc female, blonde bob   # 38
 
    male2, bandana, laser eyes  # 40

   gold, cap forward, laser eyes  #48

    blue female, nerd glasses, blonde short  # 51


    skeleton female, bandana, cigarette #55
 
    orc female, mole, frumpy hair, green eye shadow  #64
 
    bot, 3d glasses #69
 
 
    alien purple female, pipe, knitted cap  #73
 
     demon, big beard  #75
     bot, classic shades, cigarette  #76
    zombie, pipe, hoodie, pipe  #78
    
    alien green, clown eyes green #84   ## was blue - possible??

    skeleton, clown eyes green   # 86
 
   bot, crazy hair  # 92
   orc, eye mask, goat, gold chain   # 93

   female3, medical mask, cigarette    # 95
TXT


specs.each_with_index do |attributes, i|
  punk = Punk12::Image.generate( *attributes )
  punk.save( "./tmp2/12px/punk#{i}.png" )
  punk.zoom(4).save( "./tmp2/12px/punk#{i}@4x.png" )
end


puts "bye"

#################################
# to run use:
#
#  $ ruby sandbox/make.rb

$LOAD_PATH.unshift( "./lib" )
require 'punkmaker'


GOLD          =  '#ffd700'
GOLDENROD     =  '#daa520'
DARKGOLDENROD =  '#b8860b'


RED    = '#ff0000'
BLUE   = '#0000ff'
ORANGE =  '#ffa500'

colors = {
  'gold_1' =>  GOLD,
  'gold_2' =>  GOLDENROD,
  'gold_3' =>  DARKGOLDENROD
}


colors.each do |name, color|
  ###
  # humans
  punk_m = Punk::Human.make( color,  gender: 'm' )
  punk_m.save( "./tmp/human-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/human-male_#{name}@4x.png" )

  punk_f = Punk::Human.make( color,  gender: 'f' )
  punk_f.save( "./tmp/human-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/human-female_#{name}@4x.png" )

  ###
  # mummies
  punk_m = Punk::Mummy.make( color,   gender: 'm' )
  punk_m.save( "./tmp/mummy-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/mummy-male_#{name}@4x.png" )

  punk_f = Punk::Mummy.make( color,  gender: 'f' )
  punk_f.save( "./tmp/mummy-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/mummy-female_#{name}@4x.png" )
end


puts "bye"
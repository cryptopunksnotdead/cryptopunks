#################################
# to run use:
#
#  $ ruby sandbox/base.rb

require 'punks'


###
# humans
base_m = Punk::Sheet.find_by( name: 'Male 4' )
base_m.save( "./tmp2/human-male4.png" )
base_m.zoom(4).save( "./tmp2/human-male4@4x.png" )

base_f = Punk::Sheet.find_by( name: 'Female 4' )
base_f.save( "./tmp2/human-female4.png" )
base_f.zoom(4).save( "./tmp2/human-female4@4x.png" )

###
# mummies
base_m = Punk::Sheet.find_by( name: 'Mummy' )
base_m.save( "./tmp2/mummy-male.png" )
base_m.zoom(4).save( "./tmp2/mummy-male@4x.png" )

base_f = Punk::Sheet.find_by( name: 'Mummy Female' )
base_f.save( "./tmp2/mummy-female.png" )
base_f.zoom(4).save( "./tmp2/mummy-female@4x.png" )


puts "bye"
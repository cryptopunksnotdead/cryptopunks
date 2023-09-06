require 'punks'


punk = YeOldePunk::Image.generate( 'Female Light',
                                   'Wild Blonde',
                                   'Blue Eye Shadow',
                                   'Hot Lipstick',
                                   'Mole' )

punk = punk.background( '#5CB5BD' )    # add sage blue-ish background ;-)

punk.save( "./tmp/marilyn.png" )
punk.zoom(4).save( "./tmp/marilyn@4x.png" )



module Pixelart
class Image
  def add( name, gender: 'f' )   ## note: default to female
      attr = YeOldePunk::Sheet.find_by( name: name,
                                        gender: gender )
      if attr.nil?
        puts "!! ERROR - attribute >#{name}< (#{gender}) not found; sorry"
        exit 1
      end

      img = Image.new( width, height )
      img.compose!( self )
      img.compose!( attr )
      img
  end
end   # class Image
end   # module Pixelart


base = YeOldePunk::Image.generate( 'Female Light',
                                   'Wild Blonde',
                                   'Blue Eye Shadow',
                                   'Hot Lipstick',
                                   'Mole' )
base = base.background( '#5CB5BD' )    # add sage blue-ish background ;-)


punk = base.add( '3D Glasses' )

punk.save( "./tmp/marilyn_1a.png" )
punk.zoom(4).save( "./tmp/marilyn_1a@4x.png" )


punk = base.add( 'VR' )

punk.save( "./tmp/marilyn_1b.png" )
punk.zoom(4).save( "./tmp/marilyn_1b@4x.png" )


punk = base.add( 'Earring' )

punk.save( "./tmp/marilyn_1c.png" )
punk.zoom(4).save( "./tmp/marilyn_1c@4x.png" )

punk = base.add( 'Medical Mask' )

punk.save( "./tmp/marilyn_1d.png" )
punk.zoom(4).save( "./tmp/marilyn_1d@4x.png" )



base = YeOldePunk::Image.generate( 'Female Light',
                                   'Wild Blonde',
                                   'Blue Eye Shadow',
                                   'Hot Lipstick',
                                   'Mole' )

punk = base.background( "Ukraine" )

punk.save( "./tmp/marilyn_1e.png" )
punk.zoom(4).save( "./tmp/marilyn_1e@4x.png" )


punk = base.background( "Rainbow" )

punk.save( "./tmp/marilyn_1f.png" )
punk.zoom(4).save( "./tmp/marilyn_1f@4x.png" )




## save attributes

img  = YeOldePunk::Sheet.find_by( name: '3D Glasses', gender: 'm' )
img.save( "./tmp/3d_glasses.png" )
img.zoom(4).save( "./tmp/3d_glasses@4x.png" )


img  = YeOldePunk::Sheet.find_by( name: 'Clown Nose', gender: 'm' )
img.save( "./tmp/clown_nose.png" )
img.zoom(4).save( "./tmp/clown_nose@4x.png" )

img  = YeOldePunk::Sheet.find_by( name: 'Smile', gender: 'm' )
img.save( "./tmp/smile.png" )



## slow motion marilyn / step-by-step marilyn


def slow_motion_punks( attributes )
  punks = []
  count = attributes.size
  (1..count).each do |limit|
    puts
    puts "==> punk with #{limit} attribute(s): #{attributes[0,limit].inspect}"
    punks << YeOldePunk::Image.generate( *attributes[0,limit])
  end
  punks
end


attributes_marilyn = [
'Female 3',
'Mole',
'Wild Blonde',
'Blue Eye Shadow',
'Hot Lipstick',
'Earring'
]

composite = ImageComposite.new( 3, 2, background: '#5CB5BD' )

slow_motion_punks( attributes_marilyn ).each do |punk|
  composite << punk
end

composite.save( "./tmp/slowmotionmarilyn.png" )
composite.zoom(4).save( "./tmp/slowmotionmarilyn@4x.png" )



attributes_seven = [
 'Male 2',
 'Mole',
 'Buck Teeth',
 'Big Beard',
 'Earring',
 'Classic Shades',
 'Cigarette',
 'Top Hat'
]


composite = ImageComposite.new( 3, 3, background: '#638596' )

composite << Image.new( 24, 24 )  # start with empty tile

slow_motion_punks( attributes_seven ).each do |punk|
  composite << punk
end

composite.save( "./tmp/slowmotionpunk.png" )
composite.zoom(4).save( "./tmp/slowmotionpunk@4x.png" )




### saudis

saudi =  Saudi::Image.generate( 'Dark 1',
                                'Stylish Mustache',
                                'White Shemagh & Gold Agal',
                                'MAX BIDDING',
                                'Rosewood Pipe')

saudi = saudi.background( '006C35' )  # green-ish saudi flag background

saudi.save( "./tmp/saudi.png" )
saudi.zoom(4).save( "./tmp/saudi@4x.png" )



puts "bye"
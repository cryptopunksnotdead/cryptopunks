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



puts "bye"
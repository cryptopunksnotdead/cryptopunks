

module Philip

  class Image < Pixelart::Image

    ## note: right-looking ("pre-phlipped") philip
    PHILIP = Pixelart::Image.read( "#{Pixelart::Module::Punks.root}/config/philip-24x24.png" )

    def self.generate( *values )
        punk = Image.new( 24, 24 )
        punk.compose!( PHILIP )

        values.each do |name|
          attribute = Punk::Sheet.find_by( name: name,
                                           gender: 'm' )
          punk.compose!( attribute )
        end

        phunk = punk.mirror
        phunk
    end
  end # class Image
end  # module Philip

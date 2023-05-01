
module Pixelart
module Dollar   ## use/rename to Greenback - why? why not?

  def self.print( img )
    raise ArgumentError, "sorry only 24x24 supported for now; called on image #{img.width}x#{img.height}"  unless img.width == 24 && img.height == 24

    ## change to greenback color palette
    dollar = Image.new( DOLLAR_FRAME.width, DOLLAR_FRAME.height )
    dollar.compose!( DOLLAR_FRAME )
    dollar.compose!( img.change_palette8bit( DOLLAR_PALETTE ), 16, 0 )
    dollar
  end


####
#  helpers
  DOLLAR_FRAME   = Image.read( "#{Module::Punkart.root}/config/dollar.png" )

  def self.frame()  DOLLAR_FRAME; end
  def self.width()  DOLLAR_FRAME.width; end
  def self.height() DOLLAR_FRAME.height; end
  def self.palette() DOLLAR_PALETTE; end


  def self._gen_palette( color )
     color = Color.parse( color )  if color.is_a?( String )

     h,s,l = Color.to_hsl( color )

     pp h
     pp s
     pp l

     darker = 0.25    ## cut-off colors starting from black
     lighter = 0.05   ## cut-off colors starting from white

     ldiff = (1.0 - darker - lighter)

     puts "  ldiff: #{ldiff}"

    colors = []
    256.times do |i|
       lnew = darker+(ldiff*i / 256.0)
       puts "  #{i} - #{lnew}"
       colors << Color.from_hsl( h, s, lnew)
    end
    colors
  end

  DOLLAR_PALETTE = _gen_palette( '#536140' )
  #=>  #536140 / rgb( 83  97  64) - hsl( 85°  20%  32%)
end # module Dollar
end # module Pixelart

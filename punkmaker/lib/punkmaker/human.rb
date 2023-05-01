

module Punk

module Human   ## make it a class - why? why not?

  BASE_M = Image.read( "#{Pixelart::Module::Punkmaker.root}/config/human-male4.png" )
  BASE_F = Image.read( "#{Pixelart::Module::Punkmaker.root}/config/human-female4.png" )


  def self.make( color,
                 eye_color: nil,
                 gender: 'm'  )
    color_map = derive_color_map( color )

    eye_color = Color.parse( eye_color )    if eye_color && eye_color.is_a?( String )

    punk = nil
    if gender == 'm'
      punk = BASE_M.change_colors( color_map )
      punk[10,12] = Color::WHITE     # left eye dark-ish pixel to white
      punk[15,12] = Color::WHITE     # right eye ---
      if eye_color
        punk[9,12]  = eye_color
        punk[14,12] = eye_color
      end
    else  ## assume 'f'
      ## for female - change lips to all black (like in male for now) - why? why not?
      color_map[ '#711010' ] = '#000000'
      punk = BASE_F.change_colors( color_map )
      punk[10,13] = Color::WHITE     # left eye dark-ish pixel to white
      punk[15,13] = Color::WHITE     # right eye ---
      if eye_color
        punk[9,13] = eye_color
        punk[14,13] = eye_color
      end
    end

    punk
  end


  def self.derive_color_map( color )
      color = Color.parse( color )  if color.is_a?( String )

      base = color

      hsl  = Color.to_hsl( color )
      pp hsl

      h, s, l = hsl
      h = h % 360   # make always positive (might be -50 or such)
      pp [h,s,l]

      darker   = Color.from_hsl(
        h,
        [0.0, s-0.05].max,
        [0.14, l-0.1].max)

      ## sub one degree on hue on color wheel (plus +10% on lightness??)
      darkest = Color.from_hsl(
                     (h-1) % 360,
                     s,
                     [0.05, l-0.1].max)


      lighter = Color.from_hsl(
                      (h+1) % 360,
                      s,
                      [1.0, l+0.1].min)

      color_map = {
         '#ead9d9'  =>   base,
         '#ffffff'  =>   lighter,
         '#a58d8d'  =>   darkest,
         '#c9b2b2'  =>   darker
      }
      color_map
  end

end   # module Human
end   # module Punk






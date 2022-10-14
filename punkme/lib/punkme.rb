## 3rd party
require 'punks'


## our own code
require_relative 'punkme/version'    # note: let version always go first



module Punkme

  WHITE         = 0xffffffff   ## note: 0xffffff (+ff) for alpha (transparency) channel
  SKINTONE_DARK = 0x713f1dff

  BASE_M = Punk::Sheet.find_by( name: 'Male 4' )
  BASE_F = Punk::Sheet.find_by( name: 'Female 4' )


class Image < Pixelart::Image

  ## change to name skintone_palette - why? why not?
  def self.derive_skintone_colors( base )
      hsl  = Color.to_hsl( base )
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

      [base, lighter, darkest, darker]
  end  # method self.derive_skintone_colors


  ## change/rename generate to make - why? why not?
  ##   or add/use alias - why? why not?
  ##
  ##  names (attributes) MUST go first -
  ##   check if possible after keyword args ???
  def self.generate( *names,
                      skintone: SKINTONE_DARK,
                       gender:  'm' )

      skintone = Color.parse( skintone )  unless skintone.is_a?( Integer )

      skintone_base,
      skintone_lighter,
      skintone_darkest,
      skintone_darker    = derive_skintone_colors( skintone )

      color_map = {
         '#ead9d9'  =>   skintone_base,
         '#ffffff'  =>   skintone_lighter,
         '#a58d8d'  =>   skintone_darkest,
         '#c9b2b2'  =>   skintone_darker
      }


      if gender == 'm'
         punk = BASE_M.change_colors( color_map )
         punk[10,12] = WHITE     # left eye dark-ish pixel to white
         punk[15,12] = WHITE     # right eye ---
         punk
      else  ## assume f/female
        ## for female - change lips to all black (like in male for now) - why? why not?
        color_map[ '#711010' ] = '#000000'
        punk = BASE_F.change_colors( color_map )
        punk[10,13] = WHITE     # left eye dark-ish pixel to white
        punk[15,13] = WHITE     # right eye ---
        punk
      end

      ## add (optional) attributes
      names.each do |name|
        img = if gender == 'm'
                 Punk::Sheet.find_by( name: name, gender: 'm', size: 'l' )
              else
                 Punk::Sheet.find_by( name: name, gender: 'f', size: 's' )
              end
         punk.compose!( img )
      end
      punk
  end   # method self.generate
end # class Image
end # module Punkme


###
#  add some convience shortcuts / alternate spelling variants
PunkMe  = Punkme


puts Pixelart::Module::Punkme.banner    # say hello

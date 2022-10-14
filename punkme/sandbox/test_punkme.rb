###
#  to run use
#     ruby -I ./lib sandbox/test_punkme.rb


require 'punkme'



colors = {
  orange:   '#F05423',
  warm_red: '#EF483E',
  red:      '#EE3342',
  purple:   '#AA4399',
  blue:     '#462E8D',
  violet:   '#BC9BC9',
}


colors.each do |color_name, color_hex|
  punk = Punkme::Image.generate( 'Wild Hair',
                                 skintone: color_hex,
                                 gender: 'm' )
  punk.save( "./tmp/punk_(m)_#{color_name}.png")
  punk.zoom(8).save( "./tmp/punk_(m)_#{color_name}@8x.png")


  punk = Punkme::Image.generate( 'Wild Hair',
                                 skintone: color_hex,
                                 gender: 'f' )
  punk.save( "./tmp/punk_(f)_#{color_name}.png")
  punk.zoom(8).save( "./tmp/punk_(f)_#{color_name}@8x.png")
end



puts "bye"



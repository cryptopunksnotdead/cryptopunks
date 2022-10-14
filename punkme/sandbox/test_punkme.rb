###
#  to run use
#     ruby -I ./lib sandbox/test_punkme.rb


require 'punkme'



skintones = {
  orange:   '#F05423',
  warm_red: '#EF483E',
  red:      '#EE3342',
  purple:   '#AA4399',
  blue:     '#462E8D',
  violet:   '#BC9BC9',
}


skintones.each do |skintone_name, skintone_hex|
  punk = Punkme::Image.generate( 'Wild Hair',
                                 skintone: skintone_hex,
                                 gender: 'm' )
  punk.save( "./tmp/punk_(m)_#{skintone_name}.png")
  punk.zoom(8).save( "./tmp/punk_(m)_#{skintone_name}@8x.png")


  punk = Punkme::Image.generate( 'Wild Hair',
                                 skintone: skintone_hex,
                                 gender: 'f' )
  punk.save( "./tmp/punk_(f)_#{skintone_name}.png")
  punk.zoom(8).save( "./tmp/punk_(f)_#{skintone_name}@8x.png")
end



puts "bye"



####
#  to run use:
#    $ ruby  generate.rb


require 'punks'


##
#  colors names
##    changed    alien purple  => alien violet
##               alien pink    => alien red magenta
##               ape yellow => ape gold
##
##    changed    red cap  => cap red
##               burger king cap  => cap burger king
##    changed   black & white => b & w


##  2 fixes:
#  no. 25  (removed Hoodie Accessory)
#     Human, Male, 2,  2,  Sombrero / Mustache
#
#  no. 84
# changed  (Alien Male Green) to
#     Human,   Male,  1,  3,  Eye Mask / Chinstrap / Fedora B & W



recs = read_csv( "./ordinalpunks.csv" )
puts "    #{recs.size} record(s)"



composite = ImageComposite.new( 10, 10, width: 24,
                                        height: 24 )


recs.each do |rec|
  id  =      rec['id']
  type =     rec['type']
  gender =   rec['gender']
  skin_tone = rec['skin_tone']
  accessories = rec['accessories'].split( '/' ).map { |acc| acc.strip }

  # note: merge type+gender+skin_tone into one attribute
  base = "#{type} #{gender}"
  base << " #{skin_tone}"       unless skin_tone.empty?

  attributes = [base] + accessories

  puts "==> generating punk ##{id}..."
  pp attributes

  img = Punk::Image.generate( *attributes )
  img.save( "./tmp/punk#{id}.png")
  img.zoom(8).save( "./tmp/punk#{id}@8x.png")

  composite << img
end


## save all-in-one composite
composite.save( "./tmp/punks.png" )
composite.zoom(4).save( "./tmp/punks@2x.png" )


puts "bye"
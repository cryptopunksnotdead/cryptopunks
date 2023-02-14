####
#  to run use:
#    $ ruby  generate.rb


require 'punks'


recs = read_csv( "./ordinalpunks.csv" )
puts "    #{recs.size} record(s)"



def rec_to_attributes( rec )
  type =     rec['type']
  gender =   rec['gender']
  skin_tone = rec['skin_tone']

  # note: merge type+gender+skin_tone into one attribute
  base = "#{type} #{gender}"
  base << " #{skin_tone}"       unless skin_tone.empty?

  accessories = rec['accessories'].split( '/' ).map { |acc| acc.strip }
  attributes = [base] + accessories
  attributes
end




composite = ImageComposite.new( 10, 10, width: 24,
                                        height: 24 )


recs.each do |rec|
  id  =  rec['id']
  puts "==> generating punk ##{id}..."

  pp rec
  attributes = rec_to_attributes( rec )
  pp attributes

  img = Punk::Image.generate( *attributes )
  img.save( "./tmp/#{id}.png")
  img.zoom(8).save( "./tmp/#{id}@8x.png")

  composite << img   ## bonus: add to composite
end


## save all-in-one composite
composite.save( "./tmp/punks.png" )
composite.zoom(4).save( "./tmp/punks@4x.png" )


puts "bye"
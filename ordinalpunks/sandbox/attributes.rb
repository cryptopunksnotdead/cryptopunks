
#####
#  export attributes


require 'punks'


recs = read_csv( "./ordinalpunks.csv" )
puts "    #{recs.size} record(s)"






def slugify( str )
   str.gsub( /[^a-zA-Z0-9]/, '' ).downcase
end


warns = []

recs.each do |rec|
  id  =  rec['id']
  puts "==>  analyzing punk ##{id}..."

  type =     rec['type']
  gender =   rec['gender']
  skin_tone = rec['skin_tone']

  # note: merge type+gender+skin_tone into one attribute
  base = "#{type} #{gender}"
  base << " #{skin_tone}"       unless skin_tone.empty?

  accessories = rec['accessories'].split( '/' ).map { |acc| acc.strip }


  img = Punk::Spritesheet.find_by( name: base )


  slug = slugify( base )

  ## norm gender - e.g.  Male => m, Female => f
  gender = gender == 'Male' ? 'm' : 'f'

  img.save( "./tmp/attributes/base-#{gender}/#{slug}.png" )
  img.zoom(8).save( "./tmp/attributes/base-#{gender}/#{slug}@8x.png" )


   ## accessories
   pp accessories
   accessories.each do |name|
     size =  gender == 'm' ? 'l' : 's'
     img = Punk::Spritesheet.find_by( name: name,
                                      gender: gender,
                                      size: size )
     slug = slugify( name )

     if img
       img.save( "./tmp/attributes/accessories-#{gender}/#{slug}.png" )
       img.zoom(8).save( "./tmp/attributes/accessories-#{gender}/#{slug}@8x.png" )
     else
       puts "!! NOT FOUND - >#{name} (#{gender})<"
       warns << "!! NOT FOUND - >#{name} (#{gender})<"
     end
   end
end



pp warns
puts "  #{warns.size} warn(s)"


puts "bye"


__END__

["!! NOT FOUND - >Frown (f)<",
 "!! NOT FOUND - >Frown (f)<",
 "!! NOT FOUND - >Smile (f)<",
 "!! NOT FOUND - >Smile (f)<",
 "!! NOT FOUND - >Frown (f)<"]
  5 warn(s)
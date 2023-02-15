####################
#  assemble spritesheet (all-in-one composite image with attributes); to run use:
#
#   $ ruby ./spritesheet.rb


require 'pixelart'



archetypes = read_csv( "archetypes.csv")
puts "  #{archetypes.size} record(s)"   #=> ???  - was: 64 records


attributes = read_csv( "attributes.csv")
puts "  #{attributes.size} record(s)"  #=> ???  - was: 133


total = archetypes.size + attributes.size

cols = 10
rows = (total/10)
rows += 1    if total % 10 != 0



sheet = ImageComposite.new( cols, rows, width: 24,
                                        height: 24 )


meta  = []  ## output meta(data) records
meta2 = []

####
#  add archetypes first


archetypes.each do |rec|
  path = rec['path']
  sheet << Image.read( "./tmp/attributes/#{path}" )

  gender     = rec['gender']
  type       = rec['type']
  skin_tone  = rec['skin_tone'] || ''
  more_names = (rec['more_names'] || '').split( '|' )


  ## note: auto-add more names
  ##   1)  name_i + gender + name_ii        (e.g.   Human Male 1 | Human 1
  ##                                             or Human Female 1)
  ##   2)  name_i + name_ii + gender_symbol (e.g. Human 1 ♂    or Human 1 ♀)

  names = []

  if gender == 'm'
    if type == "human"
      names << "male #{skin_tone}"
    else
      names  << "male #{type} #{skin_tone}"
    end
  elsif gender == 'f'
    if type == "human"
      names << "female #{skin_tone}"
    else
      names  << "female #{type} #{skin_tone}"
    end
  else
    puts "!! ERROR - unknown gender #{gender}:"
    pp rec
    exit 1
  end

  names = names + more_names
  names = names.map {|str| str.strip.gsub(/[ ]{2,}/, ' ' )}  ## normalize spaces in more names


  meta << [meta.size,
           names[0],
           gender,
           "Archetype - #{type}",
           (names[1..-1] || ([])).join( ' | '),
          ]

  meta2 << [meta2.size, names[0]]
end


####
#  add attributes


attributes.each do |rec|
  path = rec['path']
  sheet << Image.read( "./tmp/attributes/#{path}" )


  gender = rec['gender']

  names = (rec['names'] || '').split( '|' )
  names = names.map {|str| str.strip.gsub(/[ ]{2,}/, ' ' )}  ## normalize spaces in more names

   if names.size == 0
      names <<   File.basename( path, File.extname( path ))
   end


  meta << [meta.size,
            names[0],
            gender,
            "Attribute",     ## add type e.g. Hair, Hat, Glasses, etc later - why? why not?
            (names[1..-1] || ([])).join( ' | '),
          ]

  meta2 << [meta2.size, "#{names[0]} (#{gender})"]
end


headers = ['id', 'name', 'gender', 'type', 'more_names']
File.open( "./tmp/spritesheet.csv", "w:utf-8" ) do |f|
   f.write( headers.join( ', '))
   f.write( "\n")
   meta.each do |values|
     f.write( values.join( ', ' ))
     f.write( "\n" )
   end
end

headers = ['id', 'name']
File.open( "./tmp/spritesheet2.csv", "w:utf-8" ) do |f|
   f.write( headers.join( ', '))
   f.write( "\n")
   meta2.each do |values|
     f.write( values.join( ', ' ))
     f.write( "\n" )
   end
end



sheet.save( "./tmp/spritesheet.png" )
sheet.zoom(2).save( "./tmp/spritesheet@2x.png" )
sheet.zoom(4).save( "./tmp/spritesheet@4x.png" )


puts "bye"

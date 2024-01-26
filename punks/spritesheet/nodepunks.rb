####################
#  assemble spritesheet (all-in-one composite image with attributes)
#  to run use:
#    $ ruby nodepunks.rb



require 'pixelart'


ATTRIBUTES = {
   base: [
      'maxibiz',
      'black',
      'default',
      'dark', 
      'light', 
      'albino', 
      'orange', 
      'pink',   
      'zombie', 
      'orc',  
      'alien',
    ],
    accessories: [
      'mohawk', 'mohawk2',
      'mohawk-purple', 'mohawk2-purple',
      'mohawk-red', 'mohawk2-red',
      'mohawk-blonde', 'mohawk2-blonde',
    'wildhair',
    'wildhair-blonde',
    'wildhair-red',
    'wildhair-purple',
    'peakspike',
    'peakspike-blonde',
    'bob',
    'bob-blonde',
    'tophat',
    'knittedcap',
    'beanie',
    'cap',
    'capforward',
    'headband',
    'hoodie',
    'goldchain',
    'earring',
    'clownnose',
    'clowneyes',
    'clowneyes-blue',
    'eyemask',
    '3dglasses',
    'polarizedshades',
    'classicshades',
    'bigshades',
    'coolshades',
    'eyepatch',
    'vr',
    'goat',
    'luxuriousbeard',
    'luxuriousbeard-light',
    'beard',
    'beard-light',
    'chinstrap',
    'chinstrap-light',
    'pipe',
 
     'cap-small',
     'cap-mcb',
     'cowboyhat',
     'wizardhat',
     'jesterhat',
     'bubblegum',
     'bandana',
     'bandana2',
     'frenchcap',
     'crown',
 
    'lasereyes-red', 'lasereyes2-red', 'lasereyes3-red',
    'lasereyes-green','lasereyes2-green', 'lasereyes3-green',
    'lasereyes-blue', 'lasereyes2-blue', 'lasereyes3-blue',
    'lasereyes-gold', 'lasereyes2-gold', 'lasereyes3-gold',
    ], 
 }.reduce( [] ) do |recs,(category, names)| 
     names.each do |name|
        ## fix-up file path by category
        path =  category == :base ? name : "#{category}/#{name}"

        img = Image.read( "../../../../welovepunks/attributes/#{path}.png" )
        recs << [name, category, img] 
     end
     recs
end



def make_composite( attributes )
  puts "   #{attributes.size} attribute(s)"

  cols = 10 
  rows = attributes.size / cols 
  rows += 1    if attributes.size % cols != 0

  composite = ImageComposite.new( cols, rows, 
                                         width: 24, height: 24 )

  attributes.each_with_index do |(name, category, img),i|
    composite << img
  end
  composite 
end


def write_attributes( path, attributes )
   puts "   #{attributes.size} attribute(s)"
   buf = ''
   headers = ['id', 'category', 'name', 'more_names']
   buf << headers.join( ', ' )
   buf << "\n"
   attributes.each_with_index do |(name, category, _),i|
       values = [i.to_s, 
                 category.to_s, 
                name.downcase.gsub( '_', ' ' ),
                '']
       buf << values.join( ', ' )
       buf << "\n"
   end
   write_text( path, buf )
end




composite = make_composite( ATTRIBUTES )
composite.save( "./tmp/nodepunks-24x24.png" )
composite.zoom(2).save( "./tmp/nodepunks-24x24@2x.png" )

write_attributes( "./tmp/nodepunks-24x24.csv", ATTRIBUTES )


puts "bye"


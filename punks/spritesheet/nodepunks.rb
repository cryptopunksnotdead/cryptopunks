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
    'joe',
    'donald',
    'ape',
    'ape-golden',
  ],
  accessories: [
    'bubblegum',
    'clownnose',
    'earring',
    'goldchain',
    'hoodie',
    'hoodiedark',
    'hoodielight',
    'headphone',
    'headphone2',
    'pipe',
    'vape',
    'cigarette',
    'medicalmask',
    'medicalmask2',
    'mole',
    'purplelipstick',
  ],
  beard: [
  'beard-light',
  'beard',
  'chinstrap-light',
  'chinstrap',
  'goat',
  'luxuriousbeard-light',
  'luxuriousbeard',
  ],
  eyes: [
  '3dglasses',
  'bigshades',
  'bigshades-green',
  'smallshades',
  'regularshades',
  'modernshades',
  'hornedrimglasses',
  'nerdglasses',
  'classicshades',
  'clowneyes-blue',
  'clowneyes',
  'coolshades',
  'eyemask',
  'eyepatch',
  'polarizedshades',
  'vr',
  ],
  hair: [
     'bob',
     'bob-blonde',
     'bob2-blonde',
     'bob2-pink',
  'longhair',
  'longhair-blonde',
  'longhair-pink',
  'mohawk-blonde',
  'mohawk-purple',
  'mohawk-red',
  'mohawk',
  'mohawk2-blonde',
  'mohawk2-purple',
  'mohawk2-red',
  'mohawk2',
  'peakspike-blonde',
  'peakspike',
  'wildhair-blonde',
  'wildhair-purple',
  'wildhair-red',
  'wildhair',
  ],
  head: [
  'bandana',
  'bandana2',
  'bandana3',
  'beanie',
  'cap-mcb',
  'cap-mcd',
  'cap-small',
  'cap',
  'cap-blue',
  'cap-red',
  'capforward',
  'policecap',
  'cowboyhat',
  'crown',
  'frenchcap',
  'headband',
  'headband-ii',
  'headband2',
  'jesterhat',
  'knittedcap',
  'fedora',
  'classichat',
  'tophat',
  'wizardhat',
  'do-rag',
  'do-rag-blue',
  'do-rag-red',
  ],
  lasereyes: [
  'lasereyes-blue',
  'lasereyes-gold',
  'lasereyes-green',
  'lasereyes-red',
  'lasereyes2-blue',
  'lasereyes2-gold',
  'lasereyes2-green',
  'lasereyes2-red',
  'lasereyes3-blue',
  'lasereyes3-gold',
  'lasereyes3-green',
  'lasereyes3-red',
  ], 
 }.reduce( [] ) do |recs,(category, names)| 
     names.each do |name|
        ## fix-up file path by category
        path =  category == :base ? name : "#{category}/#{name}"

        img = Image.read( "../../../../ordbase/welovepunks/attributes/#{path}.png" )
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


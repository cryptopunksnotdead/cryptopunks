####################
#  assemble spritesheet (all-in-one composite image with attributes)
#  to run use:
#    $ ruby 12px.rb



require 'pixelart'


ATTRIBUTES = {
   base: [
      'male1',
      'male2',
      'male3',
      'male4',
      'female1',
      'female2',
      'female3',
      'female4',
      'zombie',
      'ape',
      'alien',
      'alien_green',
      'alien_gold',
      'alien_purple_female',
      'orc',
      'orc_female',
      'demon',
      'bot',
      'skeleton',
      'skeleton_female',
      'pink_female',
      'pepe',
      'gold',
      'orange',
      'blue',
      'blue_female',
      'green',
      'green_female',
      'red',
      'red_female',
      'purple',
      'purple_female',
      'aqua'
   ],
   hair: [
      'blonde_bob',
      'crazy_hair_(f)',
      'crazy_hair_(m)',
      'mohawk_dark',
      'peak_spike',
      'purple_hair',
      'straight_hair_blonde',
      'wild_blonde',
      'wild_hair_(m)',
      'wild_hair_(f)',
      'wild_white_hair',
      'half_shaved',
      'half_shaved_blonde',
      'half_shaved_purple',
      'mohawk_thin',
      'mohawk',
      'red_mohawk',
      'messy_hair_(m)',
      'messy_hair_(f)',
      'messy_hair_green_(f)',
      'messy_hair_blonde_(f)',
      'dark_hair',
      'straight_hair',
      'straight_hair_dark',
      'shaved_head',
      'blonde_short',
      'pink_short',
      'stringy_hair',
      'frumpy_hair_(f)',
      'frumpy_hair_(m)',
      'orange_side',
      'blonde_side',
      'white_side',
      'pink_with_hat',
      'clown_hair_green_(f)',
      'clown_hair_green_(m)',
      'clown_hair_blue_(m)',
      'vampire_hair',
      'pigtails', 
      'pigtails_red',
      'pigtails_blonde',
   ],
   head: [
      'bandana',
      'cap',
      'cap_forward',
      'cowboy_hat',
      'headband',
      'knitted_cap',
      'top_hat',
      'beanie',
      'do-rag',
      'police_cap',
      'pilot_helmet',
      'tassle_hat',
      'fedora',
      'tiara',
   ],
   eyes: [
      '3d_glasses',
      'big_shades',
      'classic_shades',
      'clown_eyes_green',
      'clown_eyes_blue',
      'nerd_glasses',
      'regular_shades',
      'vr',
      'small_shades',
      'laser_eyes',
      'laser_eyes_gold',
      'eye_mask',
      'horned_rim_glasses',
      'eye_patch',
      'green_eye_shadow',
      'purple_eye_shadow',
      'blue_eye_shadow',
   ],
   beard: [
      'chinstrap',
      'big_beard',
      'luxurious_beard',
      'goat',
      'front_beard_dark',
      'front_beard',
      'normal_beard',
      'normal_beard_black',
      'muttonchops',
      'handlebars',
      'shadow_beard',
      'mustache',
   ],
   more: [
      'clown_nose',
      'earring',
      'hoodie',
      'choker',
      'pipe',
      'cigarette',
      'vape',
      'gold_chain',
      'silver_chain',
      'spots',
      'mole',
      'rosy_cheeks',
      'black_lipstick',
      'purple_lipstick',
      'hot_lipstick',  
      'medical_mask',
      'buck_teeth',
],
}.reduce( [] ) do |recs,(category, names)| 
     names.each do |name|
        ## fix-up file path by category
        path =  category == :base ? name : "#{category}/#{name}"

        img = Image.read( "../../../../punks.mini/attributes/#{path}.png" )
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
                                         width: 12, height: 12 )

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
composite.save( "./tmp/punks-12x12.png" )
composite.zoom(2).save( "./tmp/punks-12x12@2x.png" )

write_attributes( "./tmp/punks-12x12.csv", ATTRIBUTES )


puts "bye"


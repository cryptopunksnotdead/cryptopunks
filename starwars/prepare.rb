require 'cocos'


people  = read_json( './cache/people.json' )
species = read_json( './cache/species.json' )

puts "   #{people.size} people record(s)"
puts "   #{species.size} species record(s)"
#=> 82 people record(s)
#=> 37 species record(s)


## redo people by pk
people = people.reduce( {} ) do |h,rec|
                                 pk = rec['pk']
                                 h[ pk ] = rec['fields']
                                 h[ pk ]['pk'] = pk   ## auto-add pk too
                                h
                             end



human_ids = [
  1, 4, 5, 6, 7, 9, 10, 11, 12,
  14, 18, 19, 21, 22, 25, 26, 28,
  29, 32, 34, 35, 39, 42, 43, 51,
  60, 61, 62, 66, 67, 68, 69, 74,
  81, 82
]


stats = {
  'gender'     => Hash.new(0),
  'skin_color' => Hash.new(0),
  'hair_color' => Hash.new(0),
  'eye_color' => Hash.new(0),
}

puts "#{human_ids.size} human(s):"
human_ids.each do |id|
  rec = people[ id ]

  ## pp rec
  puts "==> #{rec['name']}"

  gender     = rec['gender']
  skin_color = rec['skin_color']
  hair_color = rec['hair_color']
  eye_color  = rec['eye_color']

  puts "  gender: #{gender}"
  puts "  skin_color: #{skin_color}"
  puts "  hair_color: #{hair_color}"
  puts "  eye_color: #{eye_color}"

  stats['gender'][ gender ] += 1
  stats['skin_color'][ skin_color ] += 1
  stats['hair_color'][ hair_color ] += 1
  stats['eye_color'][ eye_color ] += 1
end



puts "stats:"
pp stats

puts "bye"


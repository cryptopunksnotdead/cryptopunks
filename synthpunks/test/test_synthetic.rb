require 'helper'



class SyntheticTest < Minitest::Test

  def test_hex_to_int   ## hex (string) to int(eger) number
     assert_equal 10, '0xa'.to_i(16)
     assert_equal 10, 'a'.to_i(16)

     assert_equal 255, '0xff'.to_i(16)
     assert_equal 255, 'ff'.to_i(16)
     assert_equal 255, '0xFf'.to_i(16)
     assert_equal 255, '0XFF'.to_i(16)
     assert_equal 255, 'fF'.to_i(16)
  end

  def test_getTokenID
     assert_equal 30311890011735557186986086868537068337617285922, Synthpunks.getTokenID( '0x054f3b6eadc9631ccd60246054fdb0fcfe99b322' )
     assert_equal 699372119169819039191610289391678040975564001026, Synthpunks.getTokenID( '0x7a80ee32044f496a7bfef65af738fdda3a02cf02' )
     assert_equal 30311890011735557186986086868537068337617285922, Synthpunks.getTokenID( '054f3b6EADC9631ccd60246054fdb0fcfe99b322' )
     assert_equal 699372119169819039191610289391678040975564001026, Synthpunks.getTokenID( '7a80EE32044f496a7bfef65AF738fdda3a02cf02' )
  end


  def test_utils
     ## uint256_to_hex
     assert_equal "0x0000000000000000000000007a80ee32044f496a7bfef65af738fdda3a02cf02",
       Synthpunks.uint256_to_hex( 699372119169819039191610289391678040975564001026 )
  end


  SEEDS = [
    [30311890011735557186986086868537068337617285922,
        { randomUint: { 0 => 148,
                         1 => 218,
                         2 => 8,
                         20 => 25,
                         31 => 12},
          getAttributeCategories: [0,2,6,7,1],
          getAttributes: [6,20,109,114,14],
        }
      ],
    [699372119169819039191610289391678040975564001026,
        { randomUint: { 0 => 142,
                        1 => 69,
                        2 => 126,
                        31 => 245},
          getAttributeCategories: [0,1,5,7,4],
          getAttributes: [0,12,65,124,41],
        }
     ]
   ]


  def test_randomUint
     SEEDS.each do |seed, h|
        h[:randomUint].each do |offset,exp|
            assert_equal exp,  Synthpunks.randomUint( seed, offset )
        end
     end
  end

  def test_getAttributeCategories
    SEEDS.each do |seed, h|
      assert_equal h[:getAttributeCategories],  Synthpunks.getAttributeCategories( seed )
    end
 end

  def test_getAttributes
    SEEDS.each do |seed, h|
      assert_equal h[:getAttributes],  Synthpunks.getAttributes( seed )
    end
 end



end # class SyntheticTest



__END__


## for debugging
# bytes32 mask = bytes32(0xff << (offset * 8))
puts "mask:"
33.times do |offset|
  print "  #{offset} - "
  mask = 0xff << (offset * 8)
  mask_reverse = mask >> (offset *8)
  print "#{mask.to_s(16)}  (#{mask.to_s(16).size/2} byte(s)) ==  0xff << #{offset*8}"
  print " -- 0xff >> #{offset*8} == #{mask_reverse.to_s(16)}"
  print "\n"
end

=begin
mask:
  0 - ff  (1 byte(s)) ==  0xff << 0
  1 - ff00  (2 byte(s)) ==  0xff << 8
  2 - ff0000  (3 byte(s)) ==  0xff << 16
  3 - ff000000  (4 byte(s)) ==  0xff << 24
  4 - ff00000000  (5 byte(s)) ==  0xff << 32
  5 - ff0000000000  (6 byte(s)) ==  0xff << 40
  6 - ff000000000000  (7 byte(s)) ==  0xff << 48
  7 - ff00000000000000  (8 byte(s)) ==  0xff << 56
  8 - ff0000000000000000  (9 byte(s)) ==  0xff << 64
  9 - ff000000000000000000  (10 byte(s)) ==  0xff << 72
  10 - ff00000000000000000000  (11 byte(s)) ==  0xff << 80
  11 - ff0000000000000000000000  (12 byte(s)) ==  0xff << 88
  12 - ff000000000000000000000000  (13 byte(s)) ==  0xff << 96
  13 - ff00000000000000000000000000  (14 byte(s)) ==  0xff << 104
  14 - ff0000000000000000000000000000  (15 byte(s)) ==  0xff << 112
  15 - ff000000000000000000000000000000  (16 byte(s)) ==  0xff << 120
  16 - ff00000000000000000000000000000000  (17 byte(s)) ==  0xff << 128
  17 - ff0000000000000000000000000000000000  (18 byte(s)) ==  0xff << 136
  18 - ff000000000000000000000000000000000000  (19 byte(s)) ==  0xff << 144
  19 - ff00000000000000000000000000000000000000  (20 byte(s)) ==  0xff << 152
  20 - ff0000000000000000000000000000000000000000  (21 byte(s)) ==  0xff << 160
  21 - ff000000000000000000000000000000000000000000  (22 byte(s)) ==  0xff << 168
  22 - ff00000000000000000000000000000000000000000000  (23 byte(s)) ==  0xff << 176
  23 - ff0000000000000000000000000000000000000000000000  (24 byte(s)) ==  0xff << 184
  24 - ff000000000000000000000000000000000000000000000000  (25 byte(s)) ==  0xff << 192
  25 - ff00000000000000000000000000000000000000000000000000  (26 byte(s)) ==  0xff << 200
  26 - ff0000000000000000000000000000000000000000000000000000  (27 byte(s)) ==  0xff << 208
  27 - ff000000000000000000000000000000000000000000000000000000  (28 byte(s)) ==  0xff << 216
  28 - ff00000000000000000000000000000000000000000000000000000000  (29 byte(s)) ==  0xff << 224
  29 - ff0000000000000000000000000000000000000000000000000000000000  (30 byte(s)) ==  0xff << 232
  30 - ff000000000000000000000000000000000000000000000000000000000000  (31 byte(s)) ==  0xff << 240
  31 - ff00000000000000000000000000000000000000000000000000000000000000  (32 byte(s)) ==  0xff << 248
  32 - ff0000000000000000000000000000000000000000000000000000000000000000  (33 byte(s)) ==  0xff << 256
=end


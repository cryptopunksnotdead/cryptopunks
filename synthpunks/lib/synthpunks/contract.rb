

module Synthpunks

  SPRITESHEET = Pixelart::ImageComposite.read( "#{Pixelart::Module::Synthpunks.root}/config/spritesheet.png",
                                                  width: 24, height: 24 )

  SPRITESHEET_ATTRIBUTES, SPRITESHEET_RANGES  =  begin
  ## build from spritesheet.json
  config =  read_json( "#{Pixelart::Module::Synthpunks.root}/config/spritesheet.json" )

  attributes = []
  config[ 'attributes' ].each do |rec|
     attributes << rec[1]   ## get attribute name
  end

  ranges = []
  config[ 'render_order'].each do |key|
    values = config[ 'ranges'][key]
    ## note: use exclusive (three dot...) ranges !!!
    ##    e.g.  42...42 - range.size == 0 that is, MUST equal 0 !!!
    ranges << [(values[0]...values[1]),
               (values[2]...values[3])]
  end

  [attributes, ranges]
end

=begin
## note: use exclusive (three dot...) ranges !!!
SPRITESHEET_RANGES = [
[(0...7),   (7...11)],   ## base archetypes (male / female)
[(11...15), (15...19)],
[(19...22), (22...25)],
[(25...27), (27...30)],
[(30...42), (42...42)],
[(42...67), (67...106)],
[(106...110), (110...114)],
[(114...127), (127...142)],
[(142...143), (143...144)]
]

"ranges":
{"base": [0, 7, 7, 11],
"cheeks": [11, 15, 15, 19],
"mouth": [19, 22, 22, 25],
"neck": [25, 27, 27, 30],
"beard": [30, 42, 42, 42],
"headAccessory": [42, 67, 67, 106],
"mouthAccessory": [106, 110, 110, 114],
"eyes": [114, 127, 127, 142],
"ears": [142, 143, 143, 144]},
"render_order": ["base", "cheeks", "mouth",
  "neck", "beard", "headAccessory",
  "mouthAccessory", "eyes", "ears"]}
=end


#  // Entropy 1,2-9
#  function getAttributeCategories(uint256 id) public view returns (uint256[] memory) {
#    uint256[4][9] memory spritesheetRanges = assets.spritesheetRanges();
#    uint256 checks = 2 + randomUint(id, 1) % (spritesheetRanges.length - 3); // Number of bytes to check
#    uint256[] memory attributes = new uint256[](checks);
#    uint256 length = 0;
#    for (uint256 i; i < checks; i++) {
#      uint256 newAttribute = randomUint(id, 2+i) % (spritesheetRanges.length - 2) + 1; // Skip base category
#
#      bool added = contains(attributes, newAttribute);
#
#      if (added) {
#        continue;
#      }
#
#      if (getGender(id) == Gender.Female) {
#        if (!(spritesheetRanges[newAttribute][3] - spritesheetRanges[newAttribute][1] == 0)) {
#          attributes[length] = newAttribute;
#          length++;
#        }
#      } else {
#        if (!(spritesheetRanges[newAttribute][2] - spritesheetRanges[newAttribute][0] == 0)) {
#          attributes[length] = newAttribute;
#          length++;
#        }
#      }
#    }
#
#    uint256[] memory attributesResized = new uint256[](length+1);
#    attributesResized[0] = 0;
#    for (uint256 i; i < length; i++) {
#      attributesResized[i+1] = attributes[i];
#    }
#
#    return attributesResized;
#  }

  GENDER_MALE   = 0
  GENDER_FEMALE = 1


  ##  Entropy 1,2-9
  def self.getAttributeCategories( id )
     ## note: add 0 dummy for base upfront
     attributes = [0]

     gender = getGender(id)   # note: (re)use 0-MALE, 1-FEMALE for range index

    checks = 2 + randomUint(id, 1) % (SPRITESHEET_RANGES.size - 3)    ## Number of bytes to check

    checks.times do |i|
      newAttribute = randomUint(id, 2+i) % (SPRITESHEET_RANGES.size - 2) + 1  ## Skip base category

      next if attributes.include?( newAttribute )
      attributes << newAttribute   if SPRITESHEET_RANGES[newAttribute][gender].size != 0
    end

    attributes
  end


 # function getAttributes(uint256 id) public view returns (uint256[] memory) {
 #   uint256[] memory attributeCategories = getAttributeCategories(id);
 #   uint256[] memory layers = new uint256[](attributeCategories.length);
 #   for (uint256 i = 0; i < attributeCategories.length; i++) {
 #     layers[i] = getAttribute(id, attributeCategories[i]);
 #   }
 #   return layers;
 # }

 def self.getAttributes( id )
    getAttributeCategories( id ).map do |attributeCategory|
        getAttribute( id, attributeCategory )
    end
 end

 ### add a extra/bonus helper for attribute metadata names
 def self.getAttributeNames( id )
    ## note: MUST sort first for correct rendering order!!!
  getAttributes( id ).sort.map do |attribute|
      SPRITESHEET_ATTRIBUTES[attribute]
  end
end





#  // Entropy 10
#  function getAttribute(uint256 id, uint256 _attributeId) public view returns (uint256) {
#    uint256[4] memory ranges = assets.spritesheetRanges()[_attributeId];
#    Gender gender = getGender(id);
#    if (gender == Gender.Female) {
#      return ranges[1] + randomUint(id, 10+_attributeId) % (ranges[3] - ranges[1]);
#    } else {
#      return ranges[0] + randomUint(id, 10+_attributeId) % (ranges[2] - ranges[0]);
#    }
#  }


## Entropy 10
  def self.getAttribute( id, attributeId )
      gender = getGender( id )
      range = SPRITESHEET_RANGES[attributeId][ gender ]
      range.begin + randomUint( id, 10+attributeId ) % range.size
  end


#  // Entropy 0
#  function getGender(uint256 id) public view returns (Gender) {
#    return randomUint(id, 0) % 2 == 0 ? Gender.Male : Gender.Female;
#  }

## Entropy 0
def self.getGender( id )
    randomUint( id, 0 ) % 2 == 0 ? GENDER_MALE : GENDER_FEMALE
end


## note: address is really a uint160 number
##   160bit (is 20 bytes is 40 hexdigits)
##  convert to addr_to_uint
##   is really just hex_to_int  (hexstring to big integer)

## do the "on-chain" pure method in ruby here "off-chain"
#
# function getTokenID(address _address) public pure returns (uint256) {
#    return uint256(uint160(_address));
#  }

## note: (ethereum) address as hexstring (160 bit/20 bytes/40 hexdigits)
##   e.g. 0x054f3b6eadc9631ccd60246054fdb0fcfe99b322
def self.getTokenID( address )
    address.to_i( 16 )
end


# Non-standard Packed Mode
# Through abi.encodePacked(),
# Solidity supports a non-standard packed mode where:
#
# types shorter than 32 bytes are concatenated directly,
#  without padding or sign extension

  # // note:
  # //  address(this) is the address of the contract itself.
  # //   this keyword refers to the instance of a Contract.
  ADDRESS = '0xaf9CE4B327A3b690ABEA6F78eCCBfeFFfbEa9FDf'

  ## note:
  ##   returns a random unit number between 0-255 (0-ff)
  ##     use offset (0-31),that is, byte out of byte32 entropy buffer/hash

  def self.randomUint( seed, offset )
      ## assert( offset < 32, "Offset out of bounds")
      ## 256bit hash (= 32 bytes)
      entropy = keccak256( hex_to_bin( ADDRESS ) +
                           hex_to_bin( uint256_to_hex(seed)) )


      ## convert binary bytes32 buffer to unint256 (big int)
      ## uint256 = bin_to_hex(entropy).to_i(16)

      # mask = 0xff << (offset*8)
      # out = (uint256 & mask) >> (offset*8)
      # out

      ##  note: pick a uint/byte (shorter version)
      bytes = entropy.bytes.reverse
      # puts "(random) 32 bytes (from 0 to 31):"
      # pp bytes
      bytes[offset]
  end


########
##  hex-to-bin/bin-to-hex helpers
def self.uint256_to_hex( num )   ## 256 bit (=32 bytes/64 hexdigits)
   ## note: adds padding that is leading zeros
   "0x%064x" % num
end

# puts 'unit256_to_hex:'
# pp uint256_to_hex( 699372119169819039191610289391678040975564001026 )
#=> "0x0000000000000000000000007a80ee32044f496a7bfef65af738fdda3a02cf02"

def self.hex_to_bin( hex )
  raise TypeError, "Value must be an instance of String" unless hex.instance_of?( String )
  ## remove/strip hex prefix e.g. 0x/0X
  hex = hex[2..-1]  if hex.start_with?( '0x' ) ||
                       hex.start_with?( '0X' )
   [hex].pack("H*")
end

def self.bin_to_hex( bin )
  raise TypeError, "Value must be an instance of String" unless bin.instance_of?( String )
  bin.unpack("H*").first
end

def self.keccak256( bin )
  Digest::KeccakLite.new(256).digest( bin )
end
end    # module Synthpunks



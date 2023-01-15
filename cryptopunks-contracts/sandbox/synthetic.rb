##################################
#  test try SyntheticPunks
#
#  to run use:
#    $ ruby   sandbox/synthetic.rb



require 'ethlite/contracts'


contract  = SynthPunks.new


## add "pure ruby" helper
##  convert hex string (that is, address) to (big) integer
def getTokenID( address ) address.to_i( 16 ); end

pp getTokenID( '0x71c7656ec7ab88b098defb751b7401b5f6d8976f' )
#=> 649562641434947955654834859981556155081347864431
pp getTokenID( '0x0000000000000000000000000000000000000000' )
#=> 0


## function getAttributes(uint256 id)  returns (uint256[])

token_ids = [
  30311890011735557186986086868537068337617285922,
  699372119169819039191610289391678040975564001026,
  getTokenID( '0x71c7656ec7ab88b098defb751b7401b5f6d8976f' ),
]

token_ids.each do |token_id|
  puts "==> getAttributes(#{token_id}) returns:"
  ary = contract.getAttributes( token_id )
  puts
  puts "#{ary.class.name}:"
  pp ary
end



#  30311890011735557186986086868537068337617285922
# => uint256[] :  6,20,109,114,14

#  699372119169819039191610289391678040975564001026
# => uint256[] :  0,12,65,124,41

#  649562641434947955654834859981556155081347864431
# => uint256[] :  7,27,15


## function generatePunkSVG(uint256[] layers) returns (string)

specs = [
 [6,20,109,114,14],
 [0,12,65,124,41],
 [7,27,15],
]

specs.each do |attributes|
  puts
  puts "==> generatePunkSVG(#{attributes}) returns:"
  str = contract.generatePunkSVG( attributes )
  puts str
end



## function tokenURI(uint256 id) public  returns (string)

token_ids = [
  30311890011735557186986086868537068337617285922,
  699372119169819039191610289391678040975564001026,
  getTokenID( '0x71c7656ec7ab88b098defb751b7401b5f6d8976f' ),
]

token_ids.each do |token_id|
  puts "==> tokenURI(#{token_id}) returns:"
  str = contract.tokenURI( token_id )
  if str.start_with?( 'data:application/json;base64,' )
     str = str.sub( 'data:application/json;base64,', '' )
     data = JSON.parse( Base64.decode64( str ) )
     ## pp data
     ## extract image
     ##  "image"=> "data:image/svg+xml;base64
     str_image = data.delete( 'image' )
     puts
     puts str_image
     str_image = str_image.sub( 'data:image/svg+xml;base64,', '' )
     image = Base64.decode64( str_image )

     write_json( "./tmp2/punk#{token_id}.json", data )
     write_text( "./tmp2/punk#{token_id}.svg", image )
  else
    puts "!! ERROR - expected json base64-encoded; got:"
    pp str
    exit 1
  end
end




puts "bye"
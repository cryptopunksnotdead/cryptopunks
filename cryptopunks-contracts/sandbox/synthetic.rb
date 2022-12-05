require 'ethlite'

ETH_NODE  = JsonRpc.new( ENV['INFURA_URI'] )


synthetic_eth = '0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf'


def getTokenID( address ) address.to_i( 16 ); end
pp getTokenID( synthetic_eth )



## function generatePunkSVG(uint256[] memory layers) public view returns (string memory)

generatePunkSVG = Ethlite::ContractMethod.new( 'generatePunkSVG',
                      inputs: ['uint256[]'],
                      outputs: ['string'] )


specs = [
 [6,20,109,114,14],
 [0,12,65,124,41],
]

specs.each do |attributes|
  puts
  puts "==> generatePunkSVG(#{attributes}) returns:"
  str = generatePunkSVG.do_call( ETH_NODE, synthetic_eth, [attributes] )
  puts str
end



## function getAttributes(uint256 id) public view returns (uint256[] memory)
getAttributes = Ethlite::ContractMethod.new( 'getAttributes',
                                                inputs: ['uint256'],
                                                outputs: ['uint256[]'] )


token_ids = [
  30311890011735557186986086868537068337617285922,
  699372119169819039191610289391678040975564001026
]

token_ids.each do |token_id|
  puts "==> getAttributes(#{token_id}) returns:"
  ary = getAttributes.do_call( ETH_NODE, synthetic_eth, [token_id] )
  puts
  puts "#{ary.class.name}:"
  pp ary
end

#  30311890011735557186986086868537068337617285922
# => uint256[] :  6,20,109,114,14

#  699372119169819039191610289391678040975564001026
# => uint256[] :  0,12,65,124,41



## function tokenURI(uint256 id) public view override returns (string memory) {
tokenuri = Ethlite::ContractMethod.new( 'tokenURI',
                 inputs: ['uint256'],
                 outputs: ['string'] )


token_ids = [
  30311890011735557186986086868537068337617285922,
  699372119169819039191610289391678040975564001026,
  getTokenID( '0x71c7656ec7ab88b098defb751b7401b5f6d8976f' ),
]

token_ids.each do |token_id|
  puts "==> tokenURI(#{token_id}) returns:"
  str = tokenuri.do_call( ETH_NODE, synthetic_eth, [token_id] )
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
##################################
#  test try CryptoPunksTokenUri by 0xTycoon
#
#  to run use:
#    $ ruby   sandbox/tokenuri.rb


## see https://github.com/0xTycoon/punks-token-uri


require 'ethlite'

ETH_NODE  = JsonRpc.new( ENV['INFURA_URI'] )


tokenuri_eth = '0x4e776fcbb241a0e0ea2904d642baa4c7e171a1e9'


##
#  function tokenURI(uint256 _tokenId) external view returns (string memory);
tokenuri = Ethlite::ContractMethod.new( 'tokenURI',
                     inputs: ['uint256'],
                     outputs: ['string'] )

##
#  function parseAttributes(uint256 _tokenId) public view returns (string[8] memory)
parseAttributes = Ethlite::ContractMethod.new( 'parseAttributes',
                            inputs: ['uint256'],
                            outputs: ['string[8]'] )


##
#  function getAttributes(uint256 _tokenId) public view returns (string memory);
getAttributes  =  Ethlite::ContractMethod.new( 'getAttributes',
                             inputs: ['uint256'],
                             outputs: ['string'] )




token_ids = (0..3)
token_ids.each do |token_id|
   puts "==> parseAttributes(#{token_id}) returns:"
   res = parseAttributes.do_call( ETH_NODE, tokenuri_eth, [token_id] )
   puts
   puts "string[8]:"
   puts res.class.name
   pp res
end



#=> ["Female 2", "Earring", "Blonde Bob", "Green Eye Shadow", "", "", "", ""]
#=> ["Male 1", "Smile", "Mohawk", "", "", "", "", ""]
#=> ["Female 3", "Wild Hair", "", "", "", "", "", ""]


token_ids.each do |token_id|
   puts "==> getAttributes(#{token_id}) returns:"
   str = getAttributes.do_call( ETH_NODE, tokenuri_eth, [token_id] )
   data = JSON.parse( str )
   pp data
end


token_ids.each do |token_id|
   puts "==> tokenURI(#{token_id}) returns:"
   str = tokenuri.do_call( ETH_NODE, tokenuri_eth, [token_id] )
   if str.start_with?( 'data:application/json;base64,' )
      str = str.sub( 'data:application/json;base64,', '' )
      data = JSON.parse( Base64.decode64( str ) )
      ## pp data
      ## extract image
      ##  "image"=> "data:image/svg+xml;base64
      str_image = data.delete( 'image' )
      str_image = str_image.sub( 'data:image/svg+xml;base64,', '' )
      puts
      puts str_image
      image = Base64.decode64( str_image )
      ## cut-off inline leading data:image/svg+xml;utf8, too
      image = image.sub( 'data:image/svg+xml;utf8,', '' )

      write_json( "./tmp/punk#{token_id}.json", data )
      write_text( "./tmp/punk#{token_id}.svg", image )
   else
     puts "!! ERROR - expected json base64-encoded; got:"
     pp str
     exit 1
   end
end


puts "bye"
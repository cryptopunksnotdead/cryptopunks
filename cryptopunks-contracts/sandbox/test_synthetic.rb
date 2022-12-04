
## todo/ add tests for


def getTokenID( address ) address.to_i( 16 ); end

pp "0xa".to_i(16)   #=> 10
pp "a".to_i(16)     #=> 10

pp "0xff".to_i(16)  #=> 255
pp "ff".to_i(16)    #=> 255

addr1 = '0x054f3b6eadc9631ccd60246054fdb0fcfe99b322'
pp getTokenID( addr1 )
#=> 30311890011735557186986086868537068337617285922

addr2 = '0x7a80ee32044f496a7bfef65af738fdda3a02cf02'
pp getTokenID( addr2 )
#=> 699372119169819039191610289391678040975564001026




################################
## todo: add some tests for  randomUint ??????



###
#  to run use
#     ruby -I ./lib sandbox/test_tool_query.rb


require 'cryptopunks'


pp ARGV


args = ['query',
        '0',
        '1',
       ]

Punk.main( args )

puts "bye"

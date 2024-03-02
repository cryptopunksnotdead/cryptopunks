###
#  to run use
#     ruby -I ./lib sandbox/test_tool_list.rb


require 'cryptopunks'


pp ARGV


args = ['ls',
       ]

Punk.main( args )

puts "bye"

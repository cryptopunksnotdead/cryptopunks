###
#  to run use
#     ruby -I ./lib sandbox/test_tool_flip.rb


require 'cryptopunks'


pp ARGV


args = ['--dir', './tmp',
        'flip',
       ]

Punk.main( args )

puts "bye"

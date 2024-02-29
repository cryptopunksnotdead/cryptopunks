###
#  to run use
#     ruby -I ./lib sandbox/test_tool_gen.rb


require 'cryptopunks'


pp ARGV


args = ['--dir', './tmp',
        'g',
        'alien',
        'headband'
       ]

Punk.main( args )

puts "bye"

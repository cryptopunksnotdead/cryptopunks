###
#  to run use
#     ruby -I ./lib sandbox/test_tool_more.rb


require 'cryptopunks'


pp ARGV

=begin
args = ['--file', './morepunks.png',
        '--offset', '10000',
        '--dir', './tmp',
        'tile', '0', '18', '40', '88'
       ]
=end

args = ['--file', './morepunks.png',
        '--offset', '10000',
        '--dir', './tmp',
        'tile', '100', '179', '180', '190'
       ]

args += ['--zoom', '4']  if ARGV[0] == 'zoom'



Punk.main( args )

puts "bye"

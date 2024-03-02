
module Punk

class Tool

  class Opts  ## use nested Opts class (inside Tool) - why? why not?
    def verbose=(boolean)   # add: alias for debug ??
      @verbose = boolean
    end
  
    def verbose?
      return false if @verbose.nil?   # default verbose/debug flag is false
      @verbose == true
    end
  
    def file()    @file || './punks.png';  end
    def file?()   @file;  end    ## note: let's you check if file is set (or "untouched")
    def file=(file) @file = file; end
  
    def zoom()    @zoom || 1; end
    def zoom?()   @zoom;  end
    def zoom=(num) @zoom = num; end
  
    def offset()  @offset || 0; end
    def offset?() @offset;  end
    def offset=(num) @offset = num; end
  
    def outdir()  @outdir || '.'; end
    def outdir?() @outdir;  end
    def outdir=(dir) @outdir = dir;  end
  
    ### use a standard (default) seed - why? why not?
    def seed()  @seed || 4142; end
    def seed?() @seed;  end
    def seed=(num) @seed = num; end
  end # class Opts
    

##  use def self.run instead of run  e.g.
##           Tool.run( ARGV ) vs Tool.new.run( ARGV )  
def run( args )  
opts = Opts.new

parser = CmdParse::CommandParser.new(handle_exceptions: :no_help)
parser.main_options.program_name = 'punk'
parser.main_options.banner = 'punk (or cryptopunk) command line tool'
parser.main_options.version = Pixelart::Module::Cryptopunks::VERSION



parser.global_options do |opt|
      opt.on( '-z', '--zoom=NUM', Integer, 
              "Zoom factor x2, x4, x8, etc. (default: #{opts.zoom})" 
            ) do |num|
             opts.zoom = num
            end

      opt.on( '--offset=NUM', Integer, 
              "Start counting at offset (default: #{opts.offset})"   
            ) do |num|
              opts.offset = num
            end     

      ## todo - move to shuffle (only used by shuffle) - why? why not?      
      opt.on( '--seed=NUM', Integer,
              "Seed for random number generation / shuffle (default: #{opts.seed})"
            ) do |num|
              opts.seed = num
            end

      # note: remove -d alias (and --dir=DIR)  why? why not?
      opt.on(  '-o', '--out=DIR', '--dir=DIR', '--outdir=DIR', 
               "Output directory (default: #{opts.outdir})"
            ) do |dir|
               opts.outdir = dir
            end 

      ### todo/check: move option to -t/--tile command only - why? why not?
      # desc "True Official Genuine CryptoPunks™ all-in-one composite image"
      ## todo: add check that path is valid?? possible?
      opt.on( '-f', '--file=FILE', 
              "All-in-one composite image (default: #{opts.file})"
            ) do |file|
              opts.file = file 
            end            

      # note - not used for now - always on
      ## todo: use -w for short form? check ruby interpreter if in use too?      
      # opt.on( '--verbose',
      #         "(Debug) Show debug messages" 
      #      ) do 
      #          opts.verbose = true
      #           #     ## LogUtils::Logger.root.level = :debug
      #        end
end


# command - f, flip 
flip = CmdParse::Command.new('flip', takes_commands: false)
flip.short_desc( "Flip (vertically) all punk characters in all-in-one punk series composite (#{opts.file})" )
flip.action do
    puts "==> reading >#{opts.file}<..."
    punks = ImageComposite.read( opts.file )

    ## note: for now always assume 24x24
    tile_width = 24
    tile_height = 24
    cols = punks.width / tile_width
    rows = punks.height / tile_height

    phunks = ImageComposite.new( cols, rows,
                                 width: tile_width,
                                 height: tile_height )

    punks.each do |punk|
       phunks << punk.flip_vertically
    end

    ## make sure outdir exits (default is current working dir e.g. .)
    FileUtils.mkdir_p( opts.outdir )  unless Dir.exist?( opts.outdir )

    ## note: always assume .png extension for now
    basename = File.basename( opts.file, File.extname( opts.file ) )
    path  = "#{opts.outdir}/#{basename}-flipped.png"
    puts "==> saving phunks flipped one-by-one by hand to >#{path}<..."

    phunks.save( path )
    puts 'Done.'
end # action


# command - s, shuffle
shuffle = CmdParse::Command.new('shuffle', takes_commands: false)
shuffle.short_desc( "Shuffle all punk characters (randomly) in all-in-one punk series composite (#{opts.file})" )
shuffle.action do 
    puts "==> reading >#{opts.file}<..."
    punks = ImageComposite.read( opts.file )

    ## note: for now always assume 24x24
    tile_width = 24
    tile_height = 24
    cols = punks.width / tile_width
    rows = punks.height / tile_height

    phunks = ImageComposite.new( cols, rows,
                                 width: tile_width,
                                 height: tile_height )

    tiles = cols * rows
    indexes = (0..tiles-1).to_a
    srand( opts.seed )     ## note: for new reset **global** random seed and use (builtin) Array#shuffle
    puts "   using random generation number seed >#{opts.seed}< for shuffle"
    indexes = indexes.shuffle

    ###
    # seed 4142 ends in [..., 7566, 828, 8987, 9777]
    #       333 ends in [..., 6067, 9635, 973, 8172]

    indexes.each_with_index do |old_index,new_index|
       puts "    ##{old_index} now ##{new_index}"
       phunks << punks[old_index]
    end

    puts "    all #{tiles} old index numbers (zero-based) for reference using seed #{opts.seed}:"
    puts indexes.inspect

    ## make sure outdir exits (default is current working dir e.g. .)
    FileUtils.mkdir_p( opts.outdir )  unless Dir.exist?( opts.outdir )

    ## note: allways assume .png extension for now
    basename = File.basename( opts.file, File.extname( opts.file ) )
    path  = "#{opts.outdir}/#{basename}-#{opts.seed}.png"
    puts "==> saving p(h)unks shuffled one-by-one by hand to >#{path}<..."

    phunks.save( path )
    puts 'Done.'
end # action


# command - t, tile
tile = CmdParse::Command.new('tile', takes_commands: false)
tile.short_desc( "Get punk characters via image tiles from all-in-one punk series composite (#{opts.file}) - for IDs use 0 to 9999" )
tile.action do |*args|
    puts "==> reading >#{opts.file}<..."
    punks = ImageComposite.read( opts.file )

    puts "    setting zoom to #{opts.zoom}x"   if opts.zoom != 1

    ## make sure outdir exits (default is current working dir e.g. .)
    FileUtils.mkdir_p( opts.outdir )  unless Dir.exist?( opts.outdir )

    args.each_with_index do |arg,index|
      punk_index = arg.to_i( 10 )  ## assume base 10 decimal

      punk = punks[ punk_index ]

      punk_name = "punk-" + "%04d" % (punk_index + opts.offset)

      ##  if zoom - add x2,x4 or such
      if opts.zoom != 1
        punk = punk.zoom( opts.zoom )
        punk_name << "@#{opts.zoom}x"
      end

      path  = "#{opts.outdir}/#{punk_name}.png"
      puts "==> (#{index+1}/#{args.size}) saving punk ##{punk_index+opts.offset} to >#{path}<..."

      punk.save( path )
    end
    puts 'Done.'
end # action


# command - g, gen, generate
#   note: shorten to gen
generate = CmdParse::Command.new('gen', takes_commands: false)
generate.short_desc( "Generate punk characters from text attributes (from scratch / zero) via builtin punk spritesheet" )
generate.action do |*args|
    puts "==> generating  >#{args.join( ' + ' )}<..."
    punk = Punk::Image.generate( *args )

    puts "    setting zoom to #{opts.zoom}x"   if opts.zoom != 1

    ## make sure outdir exits (default is current working dir e.g. .)
    FileUtils.mkdir_p( opts.outdir )  unless Dir.exist?( opts.outdir )

    punk_index = 0    ## assume base 10 decimal
    punk_name = "punk-" + "%04d" % (punk_index + opts.offset)

    ##  if zoom - add x2,x4 or such
    if opts.zoom != 1
      punk = punk.zoom( opts.zoom )
      punk_name << "@#{opts.zoom}x"
    end

    path  = "#{opts.outdir}/#{punk_name}.png"
    puts "==> saving punk ##{punk_index+opts.offset} to >#{path}<..."

    punk.save( path )
    puts 'Done.'
end # action



# command - q, query
query = CmdParse::Command.new('query', takes_commands: false)
query.short_desc( "Query (builtin off-chain) punk contract for punk text attributes by IDs - use 0 to 9999" )
query.action do |*args|
    args.each_with_index do |arg,index|
      punk_index = arg.to_i( 10 )  ## assume base 10 decimal

      puts "==> (#{index+1}/#{args.size}) punk ##{punk_index}..."

      attribute_names = CryptopunksData.punk_attributes( punk_index )
      ## downcase name and change spaces to underscore
      attribute_names = attribute_names.map do |name|
                          name.downcase.gsub( ' ', '_' )
                        end

      print "  "
      print attribute_names.join( '  ' )
      print "\n"
    end
    puts 'Done.'
end


# command - l, ls    # (NOT) list 
##  note: ls (alias) is NOT possible with cmdparse gem!!!!! - ask if workaround?
##   note: as a workaround use ls for now (not list)!!!
list = CmdParse::Command.new('ls', takes_commands: false)
list.short_desc( "List all punk archetype and attribute names from builtin punk spritesheet" )
list.action do 
    # was: generator = Punk::Image.generator
    sheet = Punk::Spritesheet.builtin

    puts "==> Archetypes"
    sheet.meta.each do |rec|
      next unless rec.archetype?

      print "  "
      print "%-30s"  % "#{rec.name} / (#{rec.gender})"
      print " - #{rec.type}"
      print "\n"
    end

    puts ""
    puts "==> Attributes"
    sheet.meta.each do |rec|
      next unless rec.attribute?

      print "  "
      print "%-30s"  % "#{rec.name} / (#{rec.gender})"
      print " - #{rec.type}"
      print "\n"
    end

    puts ""
    puts "  See github.com/openpunkart/punkart.spritesheet for more."
    puts ""

    puts 'Done.'
end # action


parser.add_command(CmdParse::HelpCommand.new, default: true)
parser.add_command(CmdParse::VersionCommand.new)
parser.add_command( flip )
parser.add_command( shuffle )
parser.add_command( tile )
parser.add_command( generate )
parser.add_command( query )
parser.add_command( list )


parser.parse( args )
end  # method run
end  # class Tool
end  # moduule Punk




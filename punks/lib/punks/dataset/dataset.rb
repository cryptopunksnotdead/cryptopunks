

module Punk


class Metadata
  attr_reader :id,
              :type,
              :accessories

  alias_method  :attributes, :accessories


  def self.parse( row )   ## rename metod to build - why? why not?
     id            = row['id'].to_i( 10 )
     type          = row['type']

     ## split into array - allow accessores or aattributes key / header
     accessories   = row.has_key?( 'accessories' ) ?  row['accessories'] : row['attribuutes']  
     accessories  =  accessories.split( '/' ).map { |acc| acc.strip }
   
     ## optional count to double check - why? why not?
     count         = row.has_key?( 'count' ) ? row['count'].to_i( 10 ) : nil

     if count && count != accessories.size
        puts "!! ERROR - punk data assertion failed - expected accessories count #{count}; got #{accessories.size}"
        pp row
        exit 1
     end

     new( id: id, 
          type: type,
          accessories: accessories )
  end

  def initialize( id:, type:, accessories: [] )
    @id          = id
    @type        = type
    @accessories = accessories
  end
end  # class Metadata



  module Dataset

    def self.read( path )
      rows = []
  
      ## check if path include wildcard (*)
      ##   e.g. './datasets/punks/*.csv'
      if path.index( '*' )    ## allow glob to read multiple files - keep? why? why not?
      #=> ["./datasets/punks/0-999.csv",
      #    "./datasets/punks/1000-1999.csv",
      #    "./datasets/punks/2000-2999.csv",
      #    "./datasets/punks/3000-3999.csv",
      #    "./datasets/punks/4000-4999.csv",
      #    "./datasets/punks/5000-5999.csv",
      #    "./datasets/punks/6000-6999.csv",
      #    "./datasets/punks/7000-7999.csv",
      #    "./datasets/punks/8000-8999.csv",
      #    "./datasets/punks/9000-9999.csv"]
        datasets = Dir.glob( path )
        datasets.each do |dataset|
          rows += read_csv( dataset )
        end
      else  ## "vanilla" (single) datafile
          rows += read_csv( path )
      end
  
      # puts "  #{rows.size} rows(s)"
      #=> 10000 rows(s)


      ### wrap in punk struct for easier access
      punks = rows.map { |row| Metadata.parse( row ) }
      punks
    end
  end  # module Dataset
end  # module Punk



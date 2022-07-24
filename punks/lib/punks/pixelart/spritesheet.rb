###
##  todo: find a better name  for __Ex(tended)
##     SpriteEx, SpritesheetEx, GeneratorEx
##
##   use SpritesheetPlus/Extra/V2/?????  or such - why? why not?
##
##   merge Metadata::Sprite & Metadata::SpriteEx into one - why? why not?


###
##  move to spritesheet game for (re)use - why? why not?


module Pixelart

  class Metadata
    class SpriteEx
       ###  Extension to Sprite
       ##    incl. more (extra/extended) fields
       ##     - gender (u/f/m)
       ##     - size   (u/l/s)

      attr_reader :id, :name, :type, :gender, :size, :more_names

      def initialize( id:,
                      name:,
                      type:,
                      gender:,
                      size:,
                      more_names: [] )
         @id         = id      # zero-based index eg. 0,1,2,3, etc.
         @name       = name
         @type       = type
         @gender     = gender
         @size       = size
         @more_names = more_names
      end

      ## todo/check - find better names for type attribute/archetypes?
      ##     use (alternate name/alias) base or face  for archetypes? any others?
      def attribute?()  @type.downcase.start_with?( 'attribute' ); end
      def archetype?()  @type.downcase.start_with?( 'archetype' ); end

      def small?()     @size == 's'; end
      def large?()     @size == 'l'; end
      def universal?() @size == 'u'; end
      alias_method  :unisize?, :universal?   ## add unisize or allsizes or such - why? why not?

      def male?()      @gender == 'm'; end
      def female?()    @gender == 'f'; end
      def unisex?()    @gender == 'u'; end
   end  # class Metadata::Sprite
  end # class Metadata


class SpritesheetEx

 ######
 # static helpers  - (turn into "true" static self.class methods - why? why not?)
 #
 def self.normalize_key( str )
   ## add & e.g. B&W
    str.downcase.gsub(/[ ()&°_-]/, '').strip
 end

 def self.normalize_gender( str )
    ## e.g. Female => f
    ##      F => f
    ##  always return f/m
    str.downcase[0]
 end

 def self.normalize_size( str )
    ## e.g. U or Unisize or Univeral => u
    ##      S or Small               => s
    ##      L or Large               => l
    ##   always return u/l/s
    str.downcase[0]
 end

 def self.normalize_name( str )
   ## normalize spaces in more names
   str.strip.gsub( /[ ]{2,}/, ' ' )
 end

 def normalize_key( str )     self.class.normalize_key( str ); end
 def normalize_gender( str )  self.class.normalize_gender( str ); end
 def normalize_size( str )    self.class.normalize_size( str ); end
 def normalize_name( str )    self.class.normalize_name( str ); end


 def self._build_recs( recs )   ## build and normalize (meta data) records

    ## sort by id
    recs = recs.sort do |l,r|
                       l['id'].to_i( 10 ) <=> r['id'].to_i( 10 )   # use base10 (decimal)
                     end

    ## assert all recs are in order by id (0 to size)
    recs.each_with_index do |rec, exp_id|
       id = rec['id'].to_i(10)
       if id != exp_id
          puts "!! ERROR -  meta data record ids out-of-order - expected id #{exp_id}; got #{id}"
          exit 1
       end
    end

    ## convert to "wrapped / immutable" kind-of struct
    recs = recs.map do |rec|
             id         = rec['id'].to_i( 10 )
             name       = normalize_name( rec['name'] )
             gender     = normalize_gender( rec['gender'] )
             size       = normalize_size( rec['size'] )
             type       = rec['type']

             more_names = (rec['more_names'] || '').split( '|' )
             more_names = more_names.map {|str| normalize_name( str ) }

             Metadata::SpriteEx.new(
               id:         id,
               name:       name,
               type:       type,
               gender:     gender,
               size:       size,
               more_names: more_names )
           end
    recs
 end  # method _build_recs

 def self.read_records( path )
    recs = CsvHash.read( path )
    _build_recs( recs )
 end
 class << self
   alias_method :read_meta, :read_records
 end

 def self.read( image_path="./spritesheet.png",
                meta_path="./spritesheet.csv",
                  width: 24,
                  height: 24)
   img = ImageComposite.read( image_path, width: width, height: height )
   recs = read_records( meta_path )

   new( img, recs, width: width, height: height )
 end



 def initialize( img,
                 recs,
                 width: 24,
                 height: 24 )
    @width  = width
    @height = height

    ## todo: check if img is a ImageComposite or plain Image?
    ##              if plain Image "auto-wrap" into ImageComposite - why? why not?
    @image  = img
    @recs   = recs

    ## lookup by "case/space-insensitive" name / key
    @attributes_by_name = _build_attributes_by_name( @recs )
 end


 def image() @image; end
 alias_method  :composite, :image   # add some more aliases/alt names - why? why not?

 def records() @recs; end
 alias_method :meta, :records


 def find_meta_by( name:,
                   gender: nil,
                   size: nil,
                   style: nil,
                   warn: true )   ## note: gender (m/f) required for attributes!!!

    key = normalize_key( name )  ## normalize name q(uery) string/symbol

    keys = []    ## note allow lookup by more than one keys
                    ##  e.g. if gender set try   f/m first and than try unisex as fallback
    if gender
       gender = normalize_gender( gender )
       ## auto-fill size if not passed in
       ##    for f(emale)  =>   s(mall)
       ##        m(ale)    =>   l(arge)
       size =  if size.nil?
                 gender == 'f' ? 's' : 'l'
               else
                 normalize_size( size )
               end

       ###
       #  try (auto-add) style-specific version first (fallback to "regular" if not found)
       if style
         ## for now only support natural series
         style_key =  if style.downcase.start_with?( 'natural' )
                          'natural'
                      else
                        puts "!! ERROR - unknown attribute style #{style}; sorry"
                        exit 1
                      end

         keys << "#{key}#{style_key}_(#{gender}+#{size})"
         ## auto-add (u)niversal size as fallback
         keys << "#{key}#{style_key}_(#{gender}+u)"  if size == 's' || size == 'l'
         ## auto-add u(nisex) as fallback
         keys << "#{key}#{style_key}_(u+#{size})"    if gender == 'f' || gender == 'm'
       end


       keys << "#{key}_(#{gender}+#{size})"
       ## auto-add (u)niversal size as fallback
       keys << "#{key}_(#{gender}+u)"  if size == 's' || size == 'l'
       ## auto-add u(nisex) as fallback
       keys << "#{key}_(u+#{size})"    if gender == 'f' || gender == 'm'
    else
       keys << key
    end


    rec = nil
    keys.each do |key|
       rec = @attributes_by_name[ key ]
       if rec
         puts " lookup #{@image.tile_width}x#{@image.tile_height} >#{key}< => #{rec.id}: #{rec.name} / #{rec.type} (#{rec.gender}+#{rec.size})"
         # pp rec
         break
       end
    end

    if warn && rec.nil?
       puts "!! WARN - no lookup #{@image.tile_width}x#{@image.tile_height} found for #{keys.size} key(s) >#{keys.inspect}<"
    end

    rec
 end

 def find_by( name:,
              gender: nil,
              size: nil,
              style: nil,
              warn: true )  ## gender (m/f) required for attributes!!!
    rec = find_meta_by( name: name,
                        gender: gender, size: size, style: style,
                        warn: warn )

    ## return image if record found
    rec ? @image[ rec.id ] : nil
 end

#############
# helpers
def _build_attributes_by_name( recs )
  h = {}
  recs.each_with_index do |rec|
    names = [rec.name] + rec.more_names

    names.each do |name|
      key = normalize_key( name )
      key << "_(#{rec.gender}+#{rec.size})"  if rec.attribute?

      if h[ key ]
        puts "!!! ERROR - attribute name is not unique:"
        pp rec
        puts "duplicate:"
        pp h[key]
        exit 1
      end
      h[ key ] = rec
    end
 end
  ## pp h
  h
end

end # class SpritesheetEx
end # module Pixelart

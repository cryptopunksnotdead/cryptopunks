
module Pixelart
module Module
module Punks

  MAJOR = 0
  MINOR = 5
  PATCH = 3
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end

  def self.banner
    "punks/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] in (#{root})"
  end

  def self.root
    File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )
  end

end # module Punks
end # module Module
end # module Pixelart


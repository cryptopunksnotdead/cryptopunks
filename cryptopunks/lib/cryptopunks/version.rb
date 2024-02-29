

module Pixelart
module Module
module Cryptopunks

  MAJOR = 2024
  MINOR = 2
  PATCH = 29
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end

  def self.banner
    "cryptopunks/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] in (#{root})"
  end

  def self.root
    File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )
  end

end # module Cryptopunks
end # module Module
end # module Pixelart


# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "cryptopunks-gui"
  gem.homepage = "http://github.com/AndyObtiva/cryptopunks-gui"
  gem.license = "MIT"
  gem.summary = %Q{Cryptopunks GUI for Simplified Minting}
  gem.description = %Q{Cryptopunks GUI for simplified minting built with Glimmer DSL for Tk (requires ActiveTcl to run cryptopunks-gui command)}
  gem.email = "andy.am@gmail.com"
  gem.authors = ["Andy Maleh"]
  gem.executables = ['cryptopunks-gui']
  gem.files = ['README.md', 'CHANGELOG.md', 'VERSION', 'LICENSE.txt', 'cryptopunks-gui.gemspec', 'bin/**/*', 'app/**/*', 'icons/**/*']
  gem.require_paths = ['app']
  gem.post_install_message = "To launch CryptoPunks GUI, run command: cryptopunks-gui"

  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "cryptopunks-gui #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

#!/usr/bin/env ruby

Gem.paths = {
  'GEM_HOME' => File.expand_path('../../ruby-3.0.2@cryptopunks-gui', __dir__),
  'GEM_PATH' => Gem.paths.path + [File.expand_path('../../ruby-3.0.2@cryptopunks-gui', __dir__)],
  'GEM_SPEC_CACHE' => Gem.paths.spec_cache_dir
}
require_relative '../app/cryptopunks_gui.rb'

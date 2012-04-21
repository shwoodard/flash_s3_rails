# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "flash_s3/version"

Gem::Specification.new do |s|
  s.name        = "flash_s3_rails"
  s.version     = FlashS3::VERSION
  s.authors     = ["Sam Woodard"]
  s.email       = ["sam.h.woodard@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Direct multi-file uploader to s3}
  s.description = %q{Direct multi-file uploader to s3}

  s.rubyforge_project = "flash_s3"

  s.files         = `git ls-files`.split("\n") - Dir['lib/flash_s3_test/**/*']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "thin"
  s.add_development_dependency "capybara"
  s.add_development_dependency "mongrel", '~> 1.2.0.pre2'
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "jquery-rails"

  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "jquery-ui-rails"
end

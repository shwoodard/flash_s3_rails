# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "flash_s3/version"

Gem::Specification.new do |s|
  s.name        = "flash_s3"
  s.version     = FlashS3::VERSION
  s.authors     = ["Sam Woodard"]
  s.email       = ["sam.h.woodard@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Direct multi-file uploader to s3}
  s.description = %q{Direct multi-file uploader to s3}

  s.rubyforge_project = "flash_s3"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "capybara"
  s.add_development_dependency "mongrel"
  s.add_development_dependency "database_cleaner"
  s.add_runtime_dependency "activesupport"
end

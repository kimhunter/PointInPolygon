# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pinp/version"

Gem::Specification.new do |s|
  s.name        = "pinp"
  s.version     = Pinp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kim Hunter"]
  s.email       = ["bigkm1@gmail.com"]
  s.homepage    = ""
  s.summary     = "Point in Polygon."
  s.description = "Find a point in a polygon based on Crossing Number Inclusion"
  s.rubyforge_project = "pinp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

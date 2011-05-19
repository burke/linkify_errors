# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "linkify_errors/version"

Gem::Specification.new do |s|
  s.name        = "linkify_errors"
  s.version     = LinkifyErrors::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Burke Libbey"]
  s.email       = ["burke@burkelibbey.org"]
  s.homepage    = ""
  s.summary     = %q{does things.}
  s.description = %q{does things and stuff.}

  s.add_dependency 'actionpack'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

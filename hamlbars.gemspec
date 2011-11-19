$:.push File.expand_path("../lib", __FILE__)
require "hamlbars/version"

Gem::Specification.new do |s|
  s.name        = "hamlbars"
  s.version     = Hamlbars::Version::VERSION
  s.authors     = ["Jesse Reiss"]
  s.email       = ["jessereiss@gmail.com"]
  s.homepage    = "http://github.com/gorgon/hamlbars"
  s.summary     = %q{Compile Haml templates into Handlebars templates}
  s.description = %q{Hamlbars provides a Tilt template that you can use to compile HAML into Handlebars templates for use with JavaScript application frameworks like Backbone, Spine, Knockout, or Batman}

  s.add_dependency             'sprockets', '>= 2.0.0'
  s.add_dependency             'haml'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

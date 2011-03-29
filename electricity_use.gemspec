$:.push File.expand_path("../lib", __FILE__)
require 'electricity_use/version'

Gem::Specification.new do |s|
  s.name = 'electricity_use'
  s.version = BrighterPlanet::ElectricityUse::VERSION
  s.platform = Gem::Platform::RUBY
  s.date = '2011-02-02'
  s.authors = ['Derek Kastner']
  s.email = 'dkastner@gmail.com'
  s.homepage = 'http://github.com/dkastner/electricity_use'
  s.summary = %Q{TODO: one-line summary of your gem}
  s.description = %Q{TODO: detailed description of your gem}
  s.extra_rdoc_files = [
    'LICENSE',
    'README.rdoc',
  ]

  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.7')
  s.rubygems_version = '1.3.7'
  s.specification_version = 3

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'sniff'
  s.add_dependency 'emitter'
end

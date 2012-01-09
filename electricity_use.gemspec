$:.push File.expand_path("../lib", __FILE__)
require 'electricity_use/version'

Gem::Specification.new do |s|
  s.name = 'electricity_use'
  s.version = BrighterPlanet::ElectricityUse::VERSION
  s.platform = Gem::Platform::RUBY
  s.date = '2011-02-02'
  s.authors = ['Derek Kastner', 'Ian Hough', 'Seamus Abshere', 'Andy Rossmeissl']
  s.email = 'dkastner@gmail.com'
  s.homepage = 'https://github.com/brighterplanet/electricity_use'
  s.summary = %Q{A software model in Ruby for the greenhouse gas emissions of electricity usage}
  s.description = %Q{A software model in Ruby for the greenhouse gas emissions of electricity usage}
  s.extra_rdoc_files = [
    'LICENSE',
    'LICENSE-PREAMBLE',
    'README.rdoc',
  ]
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  
  s.add_runtime_dependency 'emitter',   '~>0.11.0'
  s.add_runtime_dependency 'earth',     '~>0.11.1'
  s.add_development_dependency 'sniff', '~>0.11.4'
end

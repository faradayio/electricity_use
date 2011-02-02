require 'rubygems'
require 'bundler'
Bundler.setup

require 'bueller'
Bueller::Tasks.new

require 'sniff'
require 'sniff/rake_tasks'
Sniff::RakeTasks.define_tasks

require 'rake/rdoctask'

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "lodging #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

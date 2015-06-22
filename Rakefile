require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: :spec

require 'api/version'
require 'rdoc/task'
RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.main = 'README.rdoc'
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Api #{Api::VERSION} documentation"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.options << '--webcvs=http://github.com/paulrbr/api/tree/master/'
end

require 'gokdok'
Gokdok::Dokker.new do |gd|
  gd.repo_url = 'git@github.com:paulrbr/api.git'
  gd.doc_home = 'rdoc'
  gd.remote_path = '.'
end

# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name        = "multiuploader"
  gem.homepage    = "http://github.com/RISCfuture/multiuploader"
  gem.license     = "MIT"
  gem.summary     = %Q{Multi-file drag-and-drop file uploader using strictly HTML5}
  gem.description = %Q{A drag-and-drop multi-streaming uploader that uses XHR level 2 and the drag-drop JS API (and no Flash!).}
  gem.email       = "github@timothymorgan.info"
  gem.authors     = ["Tim Morgan"]
  gem.files       = %w( lib/**/* vendor/**/* multiuploader.gemspec LICENSE.txt README.md )
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'yard'
YARD::Rake::YardocTask.new('doc') do |doc|
  doc.options << '-m' << 'markdown' << '-M' << 'redcarpet'
  doc.options << '--protected' << '--no-private'
  doc.options << '-r' << 'README.md'
  doc.options << '-o' << 'doc'
  doc.options << '--title' << 'MultiUploader Documentation'

  doc.files = %w( lib/**/* README.md )
end

# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "multiuploader"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Morgan"]
  s.date = "2012-04-21"
  s.description = "A drag-and-drop multi-streaming uploader that uses XHR level 2 and the drag-drop JS API (and no Flash!)."
  s.email = "github@timothymorgan.info"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "LICENSE.txt",
    "README.md",
    "lib/multiuploader.rb",
    "multiuploader.gemspec",
    "vendor/assets/images/easyuploader/empty.png",
    "vendor/assets/images/easyuploader/filled.png",
    "vendor/assets/javascripts/easyuploader.js.coffee.erb",
    "vendor/assets/javascripts/multiuploader.js.coffee",
    "vendor/assets/stylesheets/easyuploader.css.scss.erb"
  ]
  s.homepage = "http://github.com/RISCfuture/multiuploader"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Multi-file drag-and-drop file uploader using strictly HTML5"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 0"])
      s.add_runtime_dependency(%q<compass>, [">= 0"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<compass>, [">= 0"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<compass>, [">= 0"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

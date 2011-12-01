$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pagify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pagify"
  s.version     = Pagify::VERSION
  s.authors     = ["Mike P. Kuhl"]
  s.email       = ["mkuhl@softmachine.at"]
  s.homepage    = "http://www.softmachine.at"
  s.summary     = "painless content without a CMS"
  s.description = "Pagify allows to create and maintain content-pages. The pages are stored in the
database an can be edited inplace, using the surprisingly powerfull mercury  editor"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.3"
  # s.add_dependency "jquery-rails"
  s.add_dependency "mercury-rails"

  s.add_development_dependency "sqlite3"
end

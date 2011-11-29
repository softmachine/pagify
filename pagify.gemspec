$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pagify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pagify"
  s.version     = Pagify::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Pagify."
  s.description = "TODO: Description of Pagify."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.3"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end

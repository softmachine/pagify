#require "pagify/routes"
#require "pagify/controller"
#require "pagify/config"
#require "pagify/model"
#require "pagify/page_model"
#require "pagify/category_model"

require 'active_support/dependencies'

module Pagify
  require_dependency "pagify/config"
  require_dependency "pagify/engine"
  require_dependency "pagify/model"
  require_dependency "pagify/routes"

  def self.setup
    yield Config
  end

  def self.reload
    require_dependency "pagify/controller"
    require_dependency "pagify/controller/base"
    require_dependency "pagify/controller/pages"
    require_dependency "pagify/controller/categories"
    require_dependency "pagify/controller/page_categories"
    require_dependency "pagify/controller/category_pages"

    require_dependency "pagify/page_model"
    require_dependency "pagify/category_model"
  end

  self.reload()
end

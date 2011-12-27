require "pagify/engine"
require "pagify/routes"
require "pagify/controller"
require "pagify/config"
require "pagify/model"
require "pagify/page_model"
require "pagify/category_model"


module Pagify

  def self.setup
    yield Config
  end
end

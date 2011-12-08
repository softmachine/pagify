require "pagify/engine"
require "pagify/routes"

module Pagify
  class Config
    @@page_title = "Pagify"
    cattr_accessor :page_title

    @@authorize = nil
    cattr_accessor :authorize

    @@authorize_show = lambda{ |page| true }
    cattr_accessor :authorize_show

    @@authorize_modify = lambda{ |page| instance_exec(page, &@@authorize)}
    cattr_accessor :authorize_modify

    @@authorize_create = lambda{ |page| instance_exec(page, &@@authorize)}
    cattr_accessor :authorize_create

  end

  def self.setup
    yield Config
  end

end

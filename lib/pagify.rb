require "pagify/engine"
require "pagify/routes"

module Pagify
  mattr_accessor :name
  @@name = "Pagify"

  mattr_accessor :authorize
  @@authorize = nil

  def self.setup
    yield self
  end

end

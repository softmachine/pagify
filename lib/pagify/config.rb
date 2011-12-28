module Pagify
  class Config
    @@page_title = "Pagify"
    cattr_accessor :page_title

    @@page_model = 'Pagify::Page'
    cattr_accessor :page_model

    @@category_model = 'Pagify::Category'
    cattr_accessor :category_model

    @@authorizer= nil
    cattr_reader :authorizer
    def self.authorize(&blk)
      @@authorizer = blk
    end

    @@show_authorizer = Proc.new { |page| true }
    cattr_reader :show_authorizer
    def self.authorize_show(&blk)
      @@show_authorizer = blk
    end

    @@modify_authorizer = Proc.new { |page| instance_exec(page, &@@authorizer)}
    cattr_reader :modify_authorizer
    def self.authorize_modify(&blk)
      @@modify_authorizer = blk
    end

    @@create_authorizer = lambda{ |page| instance_exec(page, &@@authorizer)}
    cattr_reader :create_authorizer
    def self.authorize_create(&blk)
      @@create_authorizer = blk
    end

  end
end
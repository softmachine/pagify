require 'rails/generators/migration'
require 'rails/generators/active_record'

module Pagify
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)
      desc "installs pagify artifacts into the application"

      def initializer
        copy_file 'initializer.rb', "config/initializers/pagify.rb"
      end

      def routes
        route("Pagify::Router.routes self,'/pagify'")
      end


      def migration
        migration_template 'migration.rb', 'db/migrate/create_pagify_tables'
      end


      def self.next_migration_number(path)
        ActiveRecord::Generators::Base.next_migration_number(path)
      end

    end
  end
end

module Pagify
  class Router
    def self.routes
      Rails.application.routes.draw do
        match '/editor(/*requested_uri)' => "page_editor#edit", :as => :mercury_editor
        Mercury::Engine.routes
        resources :pages
      end
    end

  end
end

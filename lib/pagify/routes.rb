module Pagify
  class Router
    def self.routes(path='/pages')
      Rails.application.routes.draw do
        Mercury::Engine.routes
        resources :pagify_pages, :as => :pagify_pages, :path => path
      end
    end

    def self.page(path, pagename)
      Rails.application.routes.draw do
        match path => 'pagify_pages#show', :defaults => { :id => pagename}
      end
    end


  end
end

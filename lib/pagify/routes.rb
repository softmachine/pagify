module Pagify
  class Router
    def self.routes(map, path='/pages')
        Mercury::Engine.routes

        map.resources :pages, :as => :pages, :controller => 'pagify/pages' do
          map.resources :categories, :as => :categories, :controller => 'pagify/categories'
        end

        map.resources :categories, :as => :categories, :controller => 'pagify/categories' do
          map.resources :pages, :as => :pages, :controller => 'pagify/pages'
        end

        map.resources :categorizations, :as => :pagify_categorizations, :controller => 'pagify/categorizations'
    end

    def self.show_routes(map, path='/pages')
      Mercury::Engine.routes
      map.resources :pages, :as => :pagify_show_pages, :path => path, :controller => 'pagify/pages', :only => [:show]
    end


    def self.page(map, path, pagename)
      name = "#{pagename}_page"
      map.match path => 'pagify/pages#show', :as => name, :defaults => { :id => pagename}
    end
  end
end

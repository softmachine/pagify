module Pagify
  class Router
    def self.routes(map, path='/pagify')
        Mercury::Engine.routes

        map.resources :pages, :as => :pages, :path => "#{path}/pages", :controller => 'pagify/pages' do
          map.member do
            map.get 'modify'
            map.put 'updatemodified'
          end
          map.resources :categories, :as => :categories, :controller => 'pagify/categories'
        end

        map.resources :categories, :as => :categories, :path => "#{path}/categories", :controller => 'pagify/categories' do
          map.resources :pages, :as => :pages, :controller => 'pagify/pages'
        end

        map.resources :categorizations, :as => :pagify_categorizations, :path => "#{path}/categorizations", :controller => 'pagify/categorizations', :only => [:create]
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

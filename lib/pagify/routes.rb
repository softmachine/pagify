module Pagify
  class Router
    cattr_accessor :mercury_included
    mercury_included = false

    def self.routes(map, path='/pagify')
        include_mercury

        map.resources :pages, :as => :pages, :path => "#{path}/pages", :controller => 'pagify/pages' do
          map.member do
            map.get 'modify'
            map.put 'updatemodified'
          end
          map.resources :categories, :as => :categories, :controller => 'pagify/page_categories', :only => [:new, :destroy] do
            map.collection do
              map.get  :add, :action => :add_categories
              map.put  :add, :action => :update_added_categories
              map.get  :remove, :action => :remove_categories
              map.put  :remove, :action => :update_removed_categories
              map.get  :edit, :action => :edit_categories
              map.put  :update, :action => :update_categories
            end
          end
        end

        map.resources :categories, :as => :categories, :path => "#{path}/categories", :controller => 'pagify/categories' do
          map.resources :pages, :as => :pages, :controller => 'pagify/category_pages', :only => [:new, :destroy] do

            map.collection do
              map.get  :add, :action => :add_pages
              map.put  :add, :action => :update_added_pages
              map.get  :remove, :action => :remove_pages
              map.put  :remove, :action => :update_removed_pages
              map.get  :edit, :action => :edit_pages
              map.put  :update, :action => :update_pages
            end
          end
        end
    end

    def self.show_routes(map, path='/pages')
      include_mercury
      map.resources :pages, :as => :pagify_show_pages, :path => path, :controller => 'pagify/pages', :only => [:show]
    end


    def self.page(map, path, pagename)
      name = "#{pagename}_page"
      page_class = Pagify::Config.page_model.constantize
      page = page_class.find_by_name(pagename)
      if page then
        map.match path => 'pagify/pages#show', :as => name, :defaults => { :id => page.id}
      else
        Rails.logger.warn ("pagify page #{pagename} does not exist !")
      end
    end

    def self.include_mercury
      Mercury::Engine.routes unless mercury_included
      mercury_included=true
    end
  end
end

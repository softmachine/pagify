module Pagify
  class Router
    def self.routes(path='/pages')
      Rails.application.routes.draw do
        Mercury::Engine.routes
        scope :module => 'pagify' do
          resources :pages, :as => :pagify_pages, :path => path
        end
      end
    end

    def self.page(path, pagename)
      Rails.application.routes.draw do
          match path => 'pagify/pages#show', :defaults => { :id => pagename}
      end
    end


  end
end

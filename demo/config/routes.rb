Demo::Application.routes.draw do
  Pagify::Router.routes self,'/pagify'

  devise_for :users

  scope :constraints => lambda{|req| true } do |s|
    match '/test/:id' => "home#test2"
    Pagify::Router.page(self, "/hug", :oida)
  end

  authenticated :user do
    root :to => "pagify/pages#show", :id => 'about'
    Pagify::Router.page(self, "/sepp", :about)
  end

  Pagify::Router.routes(self, "/admin/pages")
  Pagify::Router.page(self, "/about", :about)

  root :to => "pagify/pages#show", :id => 'home'

  match '/test/:id' => "home#test1"

  Pagify::Router.show_routes self, "/content"

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

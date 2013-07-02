Bikesales::Application.routes.draw do
 

  resources :bike_specs do  # Specification of bikes
   collection do
    get "change_model"
      get "change_picture" # Chnages the bike picture on mouse hover
      post "delete_picture"
      get "showroom"
      get "search"
       # Changes the model after make input
  end
end
  resources :bikes do # Advertisement of bikes
    collection do
      get "change_make" #Changes make after year input
      get "change_model" # Changes the model after make input
      get "change_variant" # Changes the variant after model input
      get "change_picture" # Chnages the bike picture on mouse hover
      get "search_page" # Outputs the search result of the bikes
      get "main_page" #Home page of the website
      get "search" #Homepage search button
      get "save_search"
      get "send_to_friend"
      get "enquiry"
      post "delete_picture"
  end
end
resources :contacts do
  collection do
    post "post_email"
  end
end
resources :terms_and_conditions
resources :about_us
resources :how_it_works
root to: "bikes#main_page" #Home page
devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
 resources :users do 
  member do
    get "profile"
  end

end
match '/sitemap.xml.gz' => 'sitemaps#show'
match 'showroom', to: 'bike_specs#showroom', via: [:get]
match 'sell-my-bike', to: 'bikes#new', via: [:get]

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  # match ':controller(/:action(/:id))(.:format)'
end

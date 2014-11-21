Teacher::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  resources :bites
  resources :favorites do
    member do
      post 'comment'
    end
  end
  #resources :users

  root 'bites#index'

  get '/signup', to: 'users#new'
  match '/signup', to: 'users#create', via: :post
  get '/signin', to: 'sessions#new'
  match '/signin', to: 'sessions#create', via: :post
  match '/signout', to: 'sessions#destroy', via: :delete
  get '/settings', to: 'users#settings'
  match '/settings', to: 'users#update', via: :put
  match '/settings', to: 'users#update', via: :patch
  match '/avatar', to: 'users#avatar', via: :patch
  match '/avatar', to: 'users#avatar', via: :put
  match '/askcoodinate', to: 'bites#askcoodinate', via: :post

  post '/follow/:id' => 'users#follow', :as => :follow_user
  post '/unfollow/:id' => 'users#unfollow', :as => :unfollow_user
  post '/like/:id' => 'favorites#like', :as => :like_favorite
  post '/unlike/:id' => 'favorites#unlike', :as => :unlike_favorite


  get '/aws_ec2', to: 'static_page#index'



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

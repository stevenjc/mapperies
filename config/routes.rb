Rails.application.routes.draw do
  get 'admin/index'

  get 'sessions/new'
  post 'sessions/new', to:"sessions#create"


  get 'sessions/create'

  get 'sessions/destroy'
  post 'sessions/destroy', to:"sessions#destroy"

  get 'admin' =>'admin#index'
  controller :sessions do
      get 'login' => :new
      post 'login' => :create
      delete 'logout' => :destroy
  end

  resources :users
  resources :users
  get 'account/settings'

  get 'landing/show'

  #get 'main/friends'

 # get 'main/albums'

  resources :photos
  resources :users
  get '/landing', to:"landing#show"

 # get '/', to:"mapperies#landing"

  get 'login', to:"users#index"

  get '/main', to:"main#show_map"

  get '/main/albums', to:"main#albums"

  get '/main/friends', to:"main#friends"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'landing#show'

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

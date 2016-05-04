Rails.application.routes.draw do



  get 'landing/show'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users
  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"


  resources :album_views
  resources :friends do
    member do
      get 'albums'
    end
  end

  get '/albums', to: 'albums#index'

  get "/main/form" => "main#form", as: "main_form"
  resources :main

  resources :albums do
    collection do
      post 'create'
      post 'new'
    end
    member do
      post 'photos/new'
      get '/map' => "albums#map", as:"map"
      post 'photos/create'
      get 'form', as: "album_form"
      resources :photos do
        member do
          get 'edit', to: "photos#edit"
          post 'update'
          delete 'delete', to: "photos#destroy"
        end
      end
    end
  end

  resources :photos do
    member do
      get 'edit', to: "photos#edit"
      post 'update'
      # delete 'update'
      # get 'update'
      # get 'destroy', to: "photos#destroy"
      # delete 'destroy'
    end
  end

  post "photos/create"

  post 'album_view/new'
  post 'album_view/create'

  resources :users
  resources :accounts

  get 'account/settings', as: "account_settings"
  get 'account/edit', as: "account_edit"
  patch 'account/save'


  get 'landing/show'

   get '/landing', to:"landing#show"

  get '/login', to:"login#login"

  get '/main', to:"main#index"

  get '/albums', to:"albums#index"

  get 'friends/index'
  get '/friends', to:"friends#index"
  post '/friends/index'
  post '/friends', to:"friends#index"
  get 'friends/results'
  #get '/results', to:"friends#results"
  post 'friends/results'

  post 'users/edit_pic'

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

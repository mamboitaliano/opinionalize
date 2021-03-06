Rails.application.routes.draw do


  # sessions routes

  get 'sessions/create'

  get 'sessions/destroy'


  # where the hell did this come from?

  get '/SPACER_HERE', to: 'dont#care'

  get 'index/index'


  # surveys

  get 'surveys/index' => 'surveys#index'

  get 'surveys/new' => 'surveys#new'

  get 'surveys/:id' => 'surveys#show'

  post 'surveys/create' => 'surveys#create'

  post 'surveys/:id' => 'surveys#remit'

  get 'surveys/:id/results' => 'surveys#results'

  get 'surveys/:id/edit' => 'surveys#editform', as: 'survey' # just the form to edit a survey

  put 'surveys/:id' => 'surveys#edit' # when we submit it, where it will hit

  delete 'surveys/:id' => 'surveys#delete'


  # questions routes

  get 'surveys/:survey_id/questions/index' => 'questions#index'

  get 'surveys/:survey_id/questions/new' => 'questions#new'

  post 'surveys/:survey_id/questions' => 'questions#create'

  get 'surveys/:survey_id/questions/:id' => 'questions#show'

  get 'surveys/:survey_id/questions/:id/edit' => 'questions#edit'

  put 'surveys/:survey_id/questions/:id' => 'questions#update'

  delete 'surveys/:survey_id/questions/:id' => 'questions#delete'


  # auth

  resources :users

  post 'index/login' => 'index#login'

  post 'index/signup' => 'index#signup'

  get 'index/logout' => 'index#logout'


  # Routes to handle errors

  resources :errors


  # Routes for Oauth 2.0

  get 'auth/:provider/callback', to: 'sessions#create' # handles the callback from Google back to omniauth

  get 'auth/failure', to: redirect('/') # used when an error occurs
  
  get 'signout', to: 'sessions#destroy', as: 'signout' # used when the user clicks the log out button on your website

  resources :sessions, only: [:create, :destroy]
  resource :index_controller, only: [:show]

  root to: 'index#index'
  # root to: "index#show"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

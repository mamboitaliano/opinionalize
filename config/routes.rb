Rails.application.routes.draw do

  # resources :surveys do
  #   resources :questions
  # end

  get '/SPACER_HERE', to: 'dont#care'

  get 'index/index'

  get 'surveys/index' => 'surveys#index'

  get 'surveys/new' => 'surveys#new'

  get 'surveys/:id' => 'surveys#show'

  post 'surveys/create' => 'surveys#create'

  post 'surveys/:id' => 'surveys#remit'

  get 'surveys/:id/results' => 'surveys#results'

  get 'surveys/:id/edit' => 'surveys#editform' # just the form to edit a survey

  put 'surveys/:id' => 'surveys#edit' # when we submit it, where it will hit

  delete 'surveys/:id' => 'surveys#delete'


  delete 'surveys/:survey_id/questions/:question_id' => 'surveys#delete_question', as: 'delete_question'

  # get 'users/index'

  # get 'users/show'

  resources :users

  post 'index/login' => 'index#login'

  post 'index/signup' => 'index#signup'

  get 'index/logout' => 'index#logout'

  root 'index#index'
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

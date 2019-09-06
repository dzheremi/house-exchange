Rails.application.routes.draw do
  get 'login', to: 'authentication#login'

  get 'logout', to: 'authentication#logout'

  get 'register', to: 'authentication#register'

  get 'listings', to: 'listing#list'

  get 'listing/:id', to: 'listing#view'

  get 'tenant', to: 'tenant#list'

  get 'tenant/:id', to: 'tenant#view'

  get 'search', to: 'listing#search'

  post 'search/results/listings', to: 'listing#results'

  post 'search/results/tenants', to: 'tenant#results'

  get 'featured', to: 'listing#list_featured'

  get 'points', to: 'point#list'

  get 'points/buy', to: 'point#purchase'

  post 'points/buy/process', to: 'point#process_transaction'

  get 'my/listings', to: 'listing#user_listings'

  get 'my/listings/new', to: 'listing#new'

  post 'my/listings/save', to: 'listing#save'

  get 'my/listings/edit/:id', to: 'listing#edit'

  patch 'my/listings/update/:id', to: 'listing#update'

  get 'my/listings/delete/:id', to: 'listing#delete'

  get 'my/ads', to: 'tenant#user_tenants'

  get 'my/ads/new', to: 'tenant#new'

  post 'my/ads/save', to: 'tenant#save'

  get 'my/ads/edit/:id', to: 'tenant#edit'

  patch 'my/ads/update/:id', to: 'tenant#update'

  get 'my/ads/delete/:id', to: 'tenant#delete'

  post 'book/:id', to: 'booking#new_from_listing'

  post 'offer/:id', to: 'booking#new_from_tenant'

  post 'confirm/:id', to: 'booking#save'

  get 'bookings', to: 'booking#list'

  get 'tenant/accept/:id', to: 'booking#tenant_accept'

  get 'tenant/decline/:id', to: 'booking#tenant_decline'

  get 'owner/accept/:id', to: 'booking#owner_accept'

  get 'owner/decline/:id', to: 'booking#owner_decline'

  get 'review/property/:id', to: 'review#property'

  post 'review/property/save', to: 'review#property_save'

  get 'review/user/:id', to: 'review#user'

  post 'review/user/save', to: 'review#user_save'

  get 'property/new', to: 'property#new'

  get 'property', to: 'property#list'

  get 'property/edit/:id', to: 'property#edit'

  post 'property/save', to: 'property#save'

  patch 'property/update/:id', to: 'property#update'

  get 'property/delete/:id', to: 'property#delete'

  post 'authentication/create_user', to: 'authentication#create_user'

  post 'authentication/process_login', to: 'authentication#process_login'

  root 'listing#list_featured'
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

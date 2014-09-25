TACRM::Application.routes.draw do
  
  get "transactions/new"
  get "transactions/create"
  get "portal/index"
  get "system_updates/index"
  get "users/index"
  get "users/new"
  get "users/create"
  get "users/edit"
  get "users/update"
  get "users/show"
  get "users/destroy"
  resources :profile_versions

  devise_for :users
  scope "/admin" do
    resources :users do
      get :activate, on: :member
    end
  end

  resources :transactions

  
  resources :identifications
  get 'identification/:id/doc_image/download/:version' => 'doc_image#download', as: 'download_doc_image'
  get 'identification/:id/doc_image/new' => 'doc_image#new', as: 'new_doc_image'
  get 'identification/:id/doc_image/view' => 'doc_image#view', as: 'view_doc_image'
  post 'identification/:id/doc_image/upload' => 'doc_image#upload', as: 'upload_doc_image'
  delete 'identification/:id/doc_image/destroy' => 'doc_image#destroy', as: 'delete_doc_image'
  resources :notes

  resources :members

  resources :groups

  resources :accounts

  resources :addresses

  resources :phones

  resources :profiles do
    get  :json, on: :collection
    post :json, on: :collection
    get :datatable, on: :collection
    get :corporate_index, on: :collection
    get :lock, on: :member
    get :unlock, on: :member
    delete :delete, on: :member
    post :restore, on: :member
    get :lock_all, on: :collection
    get :unlock_all, on: :collection
    get :view_deleted, on: :collection
  end
  get 'transaction/new/profile/:profile_id' => 'transactions#new', as: 'profile_new_transaction'
  get 'identifications/passports/expiring' => 'identifications#expiring', as: 'expiring_passports'
  get 'identifications/new/profile/:profile_id' => 'identifications#new', as: 'profile_new_identification'
  get 'profile/:id/panel/:panel_number' => 'profiles#show', as: 'profile_panel'
  get 'versions/profile/:profile_id' => 'profile_versions#index', as: 'versions_profile'
  get 'profile/search' => "profiles#search", as: "profile_search"
  get 'profile/type/:profile_type' => "profiles#index", as: "profiles_by_type"
  get 'profile/new/:profile_type' => "profiles#new", as: "new_profile_by_type"

  get 'profile/full_names', to: 'profiles#full_names'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'portal#index'

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

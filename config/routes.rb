Rails.application.routes.draw do

  get '/auth/google'
  get '/auth/:provider/callback', to: 'account#callback'

  post 'votes' => 'votes#create', as: :vote_for_action

  get 'votes/destroy'

  get 'story' => 'story#index', as: :story
  post 'story/choose' => 'story#set_current_story_id', as: :set_current_story
  get 'story/read/:story'=> 'story#set_current_story_id', as: :read_current_story
  get 'story/choose' => 'story#choose', as: :choose_story
  get 'story/chapter/:number'  => 'story#chapter', as: :read_chapter
  get 'story/:story/latest'  => 'story#latest', as: :read_latest_chapter

  mount Ckeditor::Engine => '/ckeditor'
  namespace :account do
    get 'subscriptions' => 'subscriptions#index', as: :subscriptions
    get 'subscriptions/available' => 'subscriptions#available', as: :available_stories
    post 'subscriptions' => 'subscriptions#add', as: :add_subscription
    post 'subscriptions/:id' => 'subscriptions#update', as: :update_subscription
    delete 'subscriptions' => 'subscriptions#remove', as: :remove_subscription
  end

  get '/account' => 'account#index', as: :account
  get '/login' => 'account#login', as: :login
  post '/login' => 'account#process_login', as: :process_login
  get '/logout' => 'account#logout', as: :logout

  namespace :manage do
    resources :users
    resources :stories do

      collection do
        get :all
      end

      member do
        get :subscribers
      end

      resources :chapters

    end
  end

  get '/about' => 'home#index'
  root 'home#index'
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

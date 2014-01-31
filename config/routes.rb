Conductor::Engine.routes.draw do
  resources :scaffolds, :routes, :annotations, :statistics, :resources, :models, :app_controllers, :mailers

  resources :migrations, only: :index do
    member do
      put :up
      put :down
    end
    collection do
      post :rollback
      get :websocket_migration
    end
  end

  resource :gemfile do
    collection do
      post :install
      get :check_install
    end
  end
  resource :database do
    collection do
      post :drop
      post :seed
      post :setup
      get :websocket_database
      get :output
    end
  end

  resource :test, only: [] do
    collection do
      get :show
      get :run_all
      get :run_model
      get :run_controller
      get :run_integration
      get :websocket_test
    end
  end

  resources :fixtures, except: [:edit, :update ,:show]
  get 'fixtures/*path', to: 'fixtures#edit', constraints: { path: /.*/ }
  patch 'fixtures/*path', to: 'fixtures#update', constraints: { path: /.*/ }

  # Routes for Editor Plugin
  get 'editor/', :to => 'editor#index'
  post 'editor/save', :to => 'editor#save', :as => 'save_editor'
  # Routes for Recorder Plugin 
  get 'recorder/', :to => 'recorder#index'
  delete 'recorder/destroy', :to => 'recorder#destroy'

  get "welcome/index"
  root "welcome#index"
end

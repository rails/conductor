Conductor::Engine.routes.draw do
  resources :scaffolds, :routes, :annotations, :statistics, :resources, :models, :app_controllers, :mailers
  resource :gemfile, :database

  resources :migrations, only: :index do
    member do
      put :up
      put :down
    end
  end

  resource :test, only: [] do
  	collection do
      get :show
  		get :run_all
      get :run_model
      get :run_controller
      get :run_integration
  	end
  end

  get "welcome/index"
  resources :fixtures, except: [:edit, :update ,:show]
  get 'fixtures/*path', to: 'fixtures#edit', constraints: { path: /.*/ }
  patch 'fixtures/*path', to: 'fixtures#update', constraints: { path: /.*/ }
  root "welcome#index"
end

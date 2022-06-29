Rails.application.routes.draw do

  get 'api/authenticate'
  resources :workers
  post "workers/availability"
  devise_for :workers, path_prefix: "session",controllers: {
    sessions: "workers/sessions"
  }
  devise_for :admins, controllers: {
    sessions: "admins/sessions"
  }

  
  get 'static_pages/home'
  root "static_pages#home"
  get 'pages/index'

  resources :candidacies
  resources :job_requests, path: "jobs" do
    get "/workers", to: "job_requests#workers"
  end
  resources :placements

  resources :clients do
    get "/employees" ,to: "clients#employees"
    match "/clients", to: "clients#index", via: "get"
    get "clients/:id", to: "clients#show"
  end
  
  
  get :send_offer_to_worker, to: "clients#send_offer_to_worker", as: :send_offer
  devise_for :clients, path_prefix: "session", controllers:{
    sessions: "clients/sessions"
  }

  match "/workers", to: "workers#index", via: "get"
  match "/profile", to: "workers#profile", via: "get"

  get 'job_required_skills/create'
  get 'workers/profile'

  get '/api/get_active_placements_current_month/:api_key.json', to: 'api#get_active_placements_current_month', as: 'api_get_active_placements_current_month'

  get "api/data", to: "api#data"
  get "api/companies", to: "api#companies"
  get "api/token", to:"api#token"
  get "api/update_token", to: "api#update_token"
  
  get "update_skills/:id", to: "job_required_skills#edit", as: "update_skills"
  post "update_skills", to: "job_required_skills#update", as: "edit_skills"
end

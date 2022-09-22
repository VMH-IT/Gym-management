Rails.application.routes.draw do
  devise_for :gymers
  devise_for :admins
  post '/sign_in', to: 'api/v1/users/admins#sign_in'
  namespace :api do
    namespace :v1 do
      namespace :users do
        resources :users
        resources :admins
        resources :account_activations, only: [:edit]
           post '/sign_in', to: 'users#sign_in'
        end
        namespace :gymers do
          resources :gymers
        end
       
    end

  
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root to: "home#index"
    
  # post '/sign_in', to: 'users#sign_in'
  # post '/sign_up', to: 'users#sign_up'
end

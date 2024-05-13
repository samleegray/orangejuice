Rails.application.routes.draw do
  resources :roles
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
                                    confirmations: 'users/confirmations', passwords: 'users/passwords' }
  resources :discussions do
    resources :posts, module: :discussions
  end
  resources :posts
  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Root is Discussions for now
  root 'discussions#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

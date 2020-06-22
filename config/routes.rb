Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  scope format: 'json' do
    resources :customers do
      resources :contacts
    end
    resources :users, only: :show
    resources :ips

    namespace :admin do
      resources :customers do
        resources :contacts
      end
      resources :users
    end
  end
end

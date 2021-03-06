Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: 'devise_token_auth/sessions'
  }
  scope format: 'json' do
    post '/pusher/auth', to: 'pusher#auth'

    resources :customers do
      get 'download', on: :collection
      get 'download_zip', on: :collection
      resources :contacts
    end

    get 'customers/generate_zoom_url', to: 'customers#generate_zoom_url'

    resources :users, only: :show do
      resources :daily_reports, only: [:index, :show, :create]
      resources :schedules
    end
    resources :ips

    namespace :admin do
      resources :customers do
        resources :contacts
      end
      resources :users, only: [:index, :show]
      post 'users/import', to: 'users#import'
    end
  end
end

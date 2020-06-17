Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  scope format: 'json' do
    resources :customers
  end
end

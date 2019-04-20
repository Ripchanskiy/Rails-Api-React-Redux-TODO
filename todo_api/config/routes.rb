Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :todos
      post 'auth/register', to: 'users#register'
      post 'auth/login', to: 'users#login'
    end
  end
end

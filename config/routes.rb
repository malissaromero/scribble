Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts do
    resources :comments
  end
  get '/signin', to: 'users#signin_prompt'
  post '/signin', to: 'users#signin'
  get '/signout', to: 'users#signout'
  
end

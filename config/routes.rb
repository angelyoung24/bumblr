Rails.application.routes.draw do
  devise_for :users
  get 'users/new'

  get 'welcome/index'

  resources :posts do
    resources :comments
end

resources :users do
    resources :posts
end

  root 'welcome#index'
end

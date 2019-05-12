Rails.application.routes.draw do
  root 'tasks#index'

  namespace :admin do
    resources :users
  end
  resources :users
  resources :tasks
  resources :sessions , only:[:new ,  :create , :destroy]
  resources :groups do
    resources :members, only:[:create, :destroy]
  end
end

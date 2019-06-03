Rails.application.routes.draw do
  
  root 'tasks#index'

  namespace :admin do
    resources :users
  end
  resources :users
  resources :tasks
  resources :sessions , only:[:new ,  :create , :destroy]
  resources :groups
  resources :group_members, only:[:create, :destroy]
  resources :labels , only:[:index]
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end

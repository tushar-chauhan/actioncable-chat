Rails.application.routes.draw do
  resources :conversations, only: [:show, :create] do
    resources :messages, only: [:index]
  end

  devise_for :users
  root to: 'site#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

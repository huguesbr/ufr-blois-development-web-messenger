Rails.application.routes.draw do
  resources :sessions, only: [:create, :destroy]
  resources :memberships
  resources :chats do
    resources :messages
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

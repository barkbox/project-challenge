Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :dogs do
    resources :likes, only: %i[create]
    delete "/:dog_id", to: "likes#destroy", as: :like
  end
  root to: "dogs#index"
end

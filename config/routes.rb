Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :dogs do
    member do
      put 'like', to: 'dogs#upvote'
      put 'dislike', to: 'dogs#downvote'
    end
  end
  root to: "dogs#index"
end

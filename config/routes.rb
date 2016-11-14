Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root 'posts#index'
  resources :posts, except: [:show] do
    post "/like", to: "likes#like_toggle"
    resources :comments, only: [:create, :destroy]
  end
  resources :follows, only: [:create, :destroy]

  get '/:identify', to: 'profile#index'
end

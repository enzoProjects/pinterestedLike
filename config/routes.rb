Rails.application.routes.draw do
  resources :comments
  resources :pins do
    member do
      put "like", to: "pins#upvote"
      put "dislike", to: "pins#downvote"
    end
    end

  get 'pins/:id'=> 'pins#mispins', as: 'pins_mispins'
  devise_for :users
  root 'home#index'
  get 'home/about'
  match '/contacts',     to: 'contacts#new',             via: 'get'
  resources "contacts", only: [:new, :create]

end

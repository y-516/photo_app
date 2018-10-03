Rails.application.routes.draw do
  resources :users do
    member do
      get 'favorite'
    end
  end
  resources:favorites,only:[:create,:destroy]
  get 'sessions/new'
  resources :sessions,only:[:new,:create,:destroy]

  root to: 'sessions#new'
  resources :pictures do
    collection do
      post :confirm
    end
  end
end

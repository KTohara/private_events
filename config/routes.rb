Rails.application.routes.draw do
  root "events#index"

  # devise_scope :user do
  #   # Redirects signing out users back to sign-in
  #   get "users", to: "devise/sessions#new"
  # end

  devise_for :users
  
  resources :users, only: %i[index show] do
    resources :invitations, only: [:index]
  end

  resources :events do
    resources :invitations, only: %i[create destroy]
    get 'search', to: 'invitations#search', as: 'invitations_search'
  end

  resources :invitations, only: %i[update]
end

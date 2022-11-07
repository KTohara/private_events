Rails.application.routes.draw do
  root "events#index"

  # devise_scope :user do
  #   # Redirects signing out users back to sign-in
  #   get "users", to: "devise/sessions#new"
  # end

  devise_for :users
  resources :users, only: %i[index show]
  resources :invitations, only: %i[index new create]
  resources :events do
    member do
      get 'attend'
      get 'unattend'
    end
  end
end

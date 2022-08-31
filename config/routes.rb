Rails.application.routes.draw do
  get 'signup', to: 'users#signup'
  
  controller :sessions do
    get 'login', action: :login
    get 'logout', action: :logout
  end

  resources :users, only: [:create]
end

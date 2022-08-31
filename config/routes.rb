Rails.application.routes.draw do
  get 'signup', to: 'users#signup'
  
  controller :sessions do
    get 'login', action: :login
    get 'logout', action: :logout
  end

  resource :session, only: [:create]
  resource :user, only: [:show, :create]
end

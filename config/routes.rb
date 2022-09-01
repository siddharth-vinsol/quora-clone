Rails.application.routes.draw do
  default_url_options({ host: '127.0.0.1', port: 3000 })
  
  controller :sessions do
    get 'login', action: :login
    get 'logout', action: :logout
  end

  resource :session, only: [:create, :destroy]
  resource :registration, path: 'signup', only: [:show, :create]
  resource :user, only: [:show]
  resource :forget_password, only: [:show, :create, :update] do
    get 'reset'
  end
  
  get 'validate', to: 'registrations#validate'
end

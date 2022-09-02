Rails.application.routes.draw do
  default_url_options({ host: '127.0.0.1', port: 3000 })
  
  controller :sessions do
    get 'login', action: :login
    get 'logout', action: :logout
  end

  resource :session, only: [:create, :destroy]
  resource :registration, path: 'signup', only: [:create] do
    get '/', action: 'new'
  end
  resource :user, only: [:show]
  resource :password, only: [:show] do
    get :reset, path: 'reset_password'
    post '/', action: 'generate_reset_token'
    patch '/', action: 'update_user_password'
  end
  
  get 'verify_email', to: 'registrations#verify_email'

end

Rails.application.routes.draw do
  default_url_options({ host: QuoraClone::Environment::HOST, port: QuoraClone::Environment::PORT })
  
  controller :sessions do
    get 'login'
    get 'logout'
  end

  resource :session, only: [:create, :destroy]
  resource :registration, path: 'signup', only: [:create] do
    get '/', action: 'new'
  end
  resource :user, only: [:show]
  resource :password, only: [:show] do
    # get :reset, path: 'reset_password'
    post '/', action: 'generate_reset_token'
    patch '/', action: 'update_password'
  end
  
  get 'verify_email', to: 'registrations#verify_email'
  get '/:token/password/reset', to: 'passwords#reset', as: 'reset_password'
end

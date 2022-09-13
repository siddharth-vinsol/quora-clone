Rails.application.routes.draw do  
  controller :sessions do
    get 'login'
    get 'logout'
  end

  resource :session, only: [:create, :destroy]
  resource :registration, path: 'signup', only: [:create] do
    get '/', action: 'new'
  end

  scope 'profile', controller: :users, as: :profile do
    get '/', action: 'show'
    get 'edit'
    get 'password'
  end
  resource :user, only: [:update] do
    patch 'password', action: :update_password
  end
  resource :password, only: [:show] do
    post '/', action: 'generate_reset_token'
    patch '/', action: 'update_password'
  end
  
  get 'verify_email', to: 'registrations#verify_email'
  get '/:token/password/reset', to: 'passwords#reset', as: 'reset_password'
end

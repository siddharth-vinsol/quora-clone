Rails.application.routes.draw do  
  controller :sessions do
    get 'login'
    get 'logout'
  end

  resource :session, only: [:create, :destroy]
  resource :registration, path: 'signup', only: [:create] do
    get '/', action: 'new'
  end
  resource :user, only: [:show, :update] do
    resource :profile, module: :users, only: [:show, :update] do
      post 'image', on: :member
    end
  end
  resource :password, only: [:show] do
    post '/', action: 'generate_reset_token'
    patch '/', action: 'update_password'
  end
  
  get 'verify_email', to: 'registrations#verify_email'
  get '/:token/password/reset', to: 'passwords#reset', as: 'reset_password'
end

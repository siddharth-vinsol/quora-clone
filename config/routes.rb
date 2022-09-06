Rails.application.routes.draw do  
  controller :sessions do
    get 'login'
    get 'logout'
  end

  resource :session, only: [:create, :destroy]
  resource :registration, path: 'signup', only: [:create] do
    get '/', action: 'new'
  end

  resource :user, only: [:show, :edit, :update], path: 'profile' do
    get 'password'
    patch 'password', action: :update_password
  end
  resource :password, only: [:show] do
    post '/', action: 'generate_reset_token'
    patch '/', action: 'update_password'
  end
  resources :questions
  
  get 'verify_email', to: 'registrations#verify_email'
  get '/:token/password/reset', to: 'passwords#reset', as: 'reset_password'
end

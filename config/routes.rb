Rails.application.routes.draw do
  root to: 'homepage#index'

  controller :sessions do
    get 'login'
    get 'logout'
  end
  scope controller: :votes, path: 'vote' do
    post 'upvote'
    post 'downvote'
  end

  resource :session, only: [:create, :destroy]
  resource :registration, path: 'signup', only: [:create] do
    get '/', action: 'new'
  end

  resource :user, only: [:edit, :update], path: 'profile' do
    get '/', action: :profile
    get 'password'
    patch 'password', action: :update_password
    get 'credit_transactions'
  end
  resources :users, only: [:show], param: :username, as: 'user_profile' do
    post 'follow', on: :member
  end
  resource :password, only: [:show] do
    post '/', action: 'generate_reset_token'
    patch '/', action: 'update_password'
  end
  resources :questions, param: :permalink do
    post 'publish', on: :member
  end
  resource :answer, only: [:create]
  resource :comment, only: [:create]
  resource :abuse_report, only: [:new, :create]
  resources :credit_packs, only: [:index]
  resource :order_transactions, only: [:create] do
    get 'success'
    get 'failure'
  end
  resources :orders, only: [:create] do
    get 'checkout', on: :member
  end

  get 'verify_email', to: 'registrations#verify_email'
  get '/:token/password/reset', to: 'passwords#reset', as: 'reset_password'

  resource :admin, only: [:show], module: :admin do
    get 'users'
    get 'questions'
    get 'answers'
    get 'comments'
    patch 'disable_entity'
  end

  scope controller: :notifications, path: 'notifications' do
    get 'unsent'
    get 'unread'
  end
end

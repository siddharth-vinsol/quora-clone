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
    patch 'remove_photo'
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
  resources :answers, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :abuse_reports, only: [:new, :create]
  resources :credit_packs, only: [:index]
  resource :order_transactions, only: [:create]
  resources :orders, only: [:create], param: :code do
    get 'checkout', on: :member
    get 'success', on: :member
    get 'failure', on: :member
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

  resource :notifications, only: [:show] do
    get 'unsent'
    get 'unread'
    post 'mark_sent'
    patch 'mark_all_read'
  end

  namespace :api do
    namespace :v1 do
      get 'feed', to: 'users#feed', format: true, constraints: { format: :json }
      resources :topics, only: [:index, :show], param: :topic
    end
  end
end

Rails.application.routes.draw do
  devise_for :users, skip: :all,
    controllers: {
      registrations: 'users/registrations',
    }
  #マイページ
  root "products#index"
  resources :mypage do [:index]
    collection do
      get 'profile'         #プロフィール
    end
  end


  resources :mypage, only: [:index, :new] do
      get 'address'
      get 'complete'
      get 'login'
      get 'member'
      get 'payment'
      get 'telephone'
    end
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'

  # TODO:仮のURIを修正
    # session
    get    'login',                 to: 'users/sessions#new',          as: :new_user_session
    post   'login',                 to: 'users/sessions#create',       as: :user_session
    delete 'logout',                to: 'users/sessions#destroy',      as: :destroy_user_session
    # registration
    get    'signup',                to: 'users/registrations#index',   as: :start_user_registration
    get    'signup/registration',   to: 'users/registrations#new',     as: :new_user_registration
    patch  'users',                 to: 'users/registrations#update',  as: :user_registration
    put    'users',                 to: 'users/registrations#update'
    delete 'users',                 to: 'users/registrations#destroy'
    post   'signup/registration',   to: 'users/registrations#create',  as: :create_user_registration
    # password
    get    'password/reset/start/', to: 'devise/passwords#new',        as: :new_user_password
    get    'password/edit',         to: 'devise/passwords#edit',       as: :edit_user_password
    patch  'users/passwords',       to: 'devise/passwords#update',     as: :user_password
    put    'users/passwords',       to: 'devise/passwords#update'
    post   'users/passwords',       to: 'devise/passwords#create'
  end
end

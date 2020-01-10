Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'signup', to: 'users/registrations#index'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #マイページ
  root "products#index"
  resources :products, only: [:show] do
    resources :purchase, only: [:index] do
      collection do
        post 'pay', to: 'purchase#pay'
        get 'done', to: 'purchase#done'
      end
    end
  end

  resources :card, only: [:new] do
    collection do
      get  'show',   to: 'card#show'
      post 'pay',    to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  resources :products, only: [:new, :destroy] 

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
end

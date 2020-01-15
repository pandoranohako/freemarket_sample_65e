Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'signup', to: 'users/registrations#index'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #マイページ
  root "products#index"
  resources :products, only: [:new, :show, :destroy] do 
    resources :purchase
  end

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
  
  #商品購入
  resources :purchase, only: [:index, :pay, :done] do
    collection do
      get 'done'
    end
  end

end

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get  'signup',    to: 'users/registrations#index'
    get  'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    post 'card',      to: 'users/registrations#create_card'
    get  'logout',    to: 'users/sessions#logout'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #マイページ


# --------------------------------
  root "products#index"
  resources :products  do
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    resources :purchase, only: [:index] do
      collection do
        post 'pay', to: 'purchase#pay'
        get 'done', to: 'purchase#done'
      end
    end
  end
  
  # ---------------------------------------
  # コンフリクトが起きたが、一時的に両方残す

  resources :card, only: [:index, :new] do
    collection do
      post 'pay',    to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  resources :mypage do [:index]
    collection do
      get  'profile'
      get 'identification'
    end
  end

end

Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #マイページ



  resources :products, only: [:show, :new, :edit, :destroy, :create]  do
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :mypage do [:index]
    collection do
      get 'profile'         #プロフィール
    end
  end

  

  root 'products#index'
# resources :products, except: :show


  resources :mypage, only: [:index, :new] do
      get 'login'
      get 'member'
      get 'payment'
      get 'telephone'
  end
end

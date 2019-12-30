Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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
  end
end

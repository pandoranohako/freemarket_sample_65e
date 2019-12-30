Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :mypage do [:index]
    collection do
      get 'profile'         #プロフィール
    end
  end
end

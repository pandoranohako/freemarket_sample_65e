Rails.application.routes.draw do
  get 'mypage/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #マイページ
  root "mypage#index"
end

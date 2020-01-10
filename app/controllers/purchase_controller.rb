class PurchaseController < ApplicationController

  require 'payjp'

  def index
    # card = Card.where(user_id: current_user.id).first
    card = Card.where(user_id: 1).first

    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :payjp_test_secret_access_key)
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end

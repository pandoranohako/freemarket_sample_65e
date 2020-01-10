class PurchaseController < ApplicationController

  require 'payjp'

  def index
    # card = Card.where(user_id: current_user.id).first
    card = Card.where(user_id: 1).first
  before_action :set_product, only: [:index, :pay, :done]
  before_action :set_card, only: [:index, :pay]

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

  def pay
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :payjp_test_secret_access_key)
    Payjp::Charge.create(
    :amount => @product.price, #支払金額
    :customer => card.customer_id, #payjpの顧客ID
    :currency => 'jpy', #日本円
  )
    redirect_to action: 'done' #完了画面に移動
  end

  def done
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_card
    # card = Card.where(user_id: current_user.id).first　#ユーザー登録機能が実装されたらこちらを使う
    card = Card.where(user_id: 1).first  
  end

end

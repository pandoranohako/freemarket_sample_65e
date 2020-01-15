class MypageController < ApplicationController

  require "payjp"

  def card_new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "card_show" if card.exists?
  end

  def card_create #payjpとCardのデータベース作成を実施します
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :payjp_test_secret_access_key) #creddential.yml.enb から呼び出せないので仮置き
    if params['payjp-token'].blank?
      redirect_to action: "card_new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', #なくてもOK
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      
      if @card.save
        redirect_to action: "card_show"
      else
        redirect_to action: "card_new"
      end
    end
  end

  def card_show #Cardのデータpayjpに送り情報を取り出します
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: "card_new" 
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :payjp_test_secret_access_key)
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def card_delete #PayjpとCardデータベースを削除します
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :payjp_test_secret_access_key)
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "card_new"
  end

end


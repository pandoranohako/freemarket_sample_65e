class CardController < ApplicationController

  require "payjp"

  before_action :set_card, only: [:index, :delete]

  def new
    card = Card.where(user_id: current_user.id)
    if card.present?
      redirect_to card_index_path
    end
  end

  def index #Cardのデータpayjpに送り情報を取り出します
    if @card.blank?
      redirect_to new_card_path
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :payjp_test_secret_access_key)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay #payjpとCardのデータベース作成を実施します
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :payjp_test_secret_access_key) #creddential.yml.enb から呼び出せないので仮置き
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', #なくてもOK
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      
      if @card.save
        redirect_to card_index_path
      else
        redirect_to new_card_path
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    if @card.present?
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :payjp_test_secret_access_key)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
    redirect_to new_card_path
  end

  private
  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

end

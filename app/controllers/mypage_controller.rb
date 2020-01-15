class MypageController < ApplicationController
  def new
  end

  def member
  end

  def telephone
  def card_new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "card_show" if card.exists?
  end

  def address
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

  def payment
  end

  def complete
  end

  def profile
  end
end


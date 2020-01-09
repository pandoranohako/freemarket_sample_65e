class CardController < ApplicationController


  require "payjp"

  def new
    card = Card.where(user_id: 1) #1をcurrent_user.idとしたい
    redirect_to action: "show" if card.exists?
  end
end

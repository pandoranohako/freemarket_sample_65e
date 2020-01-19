class MypageController < ApplicationController

  def profile
    @user = User.find(current_user.id)
  end

  def identification
  end

end


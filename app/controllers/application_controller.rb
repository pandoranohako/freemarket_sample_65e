class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  #ストロングパラメータを使用する
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

 #ストロングパラメータを使用するためにconfigure_permitted_parametersを定義  
  def  configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :password, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday_yyyy, :birthday_mm, :birthday_dd, :authentication_number])
  end

  # TODO:リダイレクト先の分岐
  def after_sign_up_path_for(resource)
    root_path
  end

  # TODO:リダイレクト先の分岐
  def after_sign_in_path_for(resource)
    root_path
  end  

end

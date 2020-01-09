class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]
         kanji = /\A[一-龥]+\z/
         kana = /\A([ァ-ン]|ー)+\z/

#アソシエーション
  has_many :products
  has_one :address
  has_many :sns_credentials, dependent: :destroy

#SNS認証 
  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { user: user ,sns: sns}
    end

   def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
   end

   def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end
  
#バリデーション設定    
  validates :name, presence: true, length: { maximum: 15 }
  validates :password, presence: true, length: { in: 7..128 },  format: { with: /\A(?=.*[^\d])+/ }
  validates :family_name, presence: true, length: { maximum: 15 }, format: { with: kanji }
  validates :first_name, presence: true, length: { maximum: 15 }, format: { with: kanji }
  validates :family_name_kana, presence: true, length: { maximum: 15 }, format: { with: kana }
  validates :first_name_kana, presence: true, length: { maximum: 15 }, format: { with: kana }
  validates :birthday_yyyy, presence: true
  validates :birthday_mm, presence: true
  validates :birthday_dd, presence: true
end

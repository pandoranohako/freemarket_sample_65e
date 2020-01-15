class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

         kana = /\A([ァ-ン]|ー)+\z/

#アソシエーション
  has_many :products, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy
  
#バリデーション設定    
  validates :name, presence: true, length: { maximum: 15 }
  validates :password, presence: true, length: { in: 7..128 },  format: { with: /\A(?=.*[^\d])+/ }
  validates :family_name, presence: true, length: { maximum: 15 }
  validates :first_name, presence: true, length: { maximum: 15 }
  validates :family_name_kana, presence: true, length: { maximum: 15 }, format: { with: kana }
  validates :first_name_kana, presence: true, length: { maximum: 15 }, format: { with: kana }
  validates :birthday_yyyy, presence: true
  validates :birthday_mm, presence: true
  validates :birthday_dd, presence: true

#SNS認証 
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
        name: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end

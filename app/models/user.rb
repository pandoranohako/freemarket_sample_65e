class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーション
  has_one  :shipping_address, dependent: :destroy

  #バリデーション設定   
  # user_registration1入力項目    
  validates :name, presence: true, length: { maximum: 20 }, on: :validates_step1
  validates :email, presence: true, uniqueness: true,  format: { with: /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*[a-zA-Z]+\z/ }, on: :validates_step1
  validates :password, presence: true, length: { in: 6..128 },  format: { with: /\A(?=.*[^\d])+/ }, on: :validates_step1
  validates :family_name, presence: true, length: { maximum: 20 }, on: :validates_step1
  validates :first_name, presence: true, length: { maximum: 20 }, on: :validates_step1
  validates :family_name_kana, presence: true, length: { maximum: 35 }, on: :validates_step1
  validates :first_name_kana, presence: true, length: { maximum: 35 }, on: :validates_step1
  validates :birthday_yyyy, presence: true, on: :validates_step1
  validates :birthday_mm, presence: true, on: :validates_step1
  validates :birthday_dd, presence: true, on: :validates_step1  

  # user_registration2入力項目
  validates :telephone, presence: true, format: { with: VALID_PHONE_REGEX, message: '有効ではありません。'}, on: :validates_step2

  # user_registration3入力項目
  validates :family_name, presence: true, length: { maximum: 20 }, on: :validates_step3
  validates :first_name, presence: true, length: { maximum: 20 }, on: :validates_step3
  validates :family_name_kana, presence: true, length: { maximum: 35 }, on: :validates_step3
  validates :first_name_kana, presence: true, length: { maximum: 35 }, on: :validates_step3

  # 下記の記述が無いと、devise機能によりemailとpasswordのバリデーションが抜けられない
  protected
  
  def password_required?
    # user_registration1のときだけバリデーションがかかるように条件分岐
    if validation_context == :user_registration1
      !persisted? || !password.nil? || !password_confirmation.nil?
    end
  end

  def email_required?
    # user_registration1のときだけバリデーションがかかるように条件分岐
    if validation_context == :user_registration1
      true
    end
  end
end

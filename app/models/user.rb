class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         kanji = /\A[一-龥]+\z/
         kana = /\A([ァ-ン]|ー)+\z/

#アソシエーション
  has_many :products
  has_one :address

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

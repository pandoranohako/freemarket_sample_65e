class Address < ApplicationRecord
  belongs_to :user, optional: true, dependent: :destroy

  #バリデーション設定     
  validates :postal_code, presence: true, length: { maximum: 7 }
  validates :address, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :building, length: { maximum: 100 }
end

class ShippingAddress < ApplicationRecord
  belongs_to :user, optional: true

  #バリデーション設定     
  validates :postal_code, presence: true, length: { maximum: 7 }
  validates :address, presence: true
  validates :prefecture, presence: true
  validates :building, length: { maximum: 100 }
  validates :telephone, allow_blank: true
end

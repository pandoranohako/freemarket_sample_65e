class ShippingAddress < ApplicationRecord
  belongs_to :user, optional: true

  #バリデーション設定     
  validates :postal_code, presence: true, length: { maximum: 7 }, on: :validates_step3
  validates :address, presence: true, on: :validates_step3
  validates :prefecture, presence: true, on: :validates_step3
  validates :building, length: { maximum: 100 }, on: :validates_step3
  validates :telephone, allow_blank: true, on: :validates_step3
end

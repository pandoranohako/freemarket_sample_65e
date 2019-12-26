class ShippingAddress < ApplicationRecord
  belongs_to :user, optional: true

  #バリデーション設定     
  validates :postal_code, presence: true, length: { maximum: 7 }, format: { with: VALID_POSTAL_CODE, message: '有効ではありません。' }, on: :validates_step3
  validates :address, presence: true, on: :validates_step3
  validates :prefecture, presence: true, on: :validates_step3
  validates :building, length: { maximum: 100 }, on: :validates_step3
  validates :telephone, format: { with: VALID_PHONE_REGEX, message: '有効ではありません。'}, allow_blank: true, on: :validates_step3
end

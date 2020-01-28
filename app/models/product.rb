class Product < ApplicationRecord
  validates :name,  :description,  :condition,  :shipping_fee,  :shipping_how,  :shipping_from,  :shipping_date, :price,  :size,  presence: true

  belongs_to :user, foreign_key: 'user_id', optional: true
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :category, foreign_key: 'category_id', optional: true
 
  
end

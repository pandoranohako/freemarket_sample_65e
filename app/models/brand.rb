class Brand < ApplicationRecord
  has_ancestry
  has_many :products
end

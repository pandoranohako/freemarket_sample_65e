class ShippingAddress < ApplicationRecord
  belongs_to :user, optional: true
end

class OrderedProduct < ApplicationRecord
  belongs_to :order_id
  belongs_to :product_id
  belongs_to :discount_id
end

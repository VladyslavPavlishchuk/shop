class OrderedProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :discount, optional: true
end

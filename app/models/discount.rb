class Discount < ApplicationRecord
  enum amount_type: [:percent, :fixed]
  enum discount_type: [:product, :user, :category]

  belongs_to :discounted, polymorphic: true
  has_many :ordered_products
end

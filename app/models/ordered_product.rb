# frozen_string_literal: true

class OrderedProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product, foreign_key: "product_id"
  belongs_to :discount, optional: true
end

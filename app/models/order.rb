class Order < ApplicationRecord
  belongs_to :user
  has_many :ordered_products
  enum status: [ :cart, :submitted, :confirmed, :completed, :canceled ]
end

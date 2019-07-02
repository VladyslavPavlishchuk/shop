class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, length: { maximum: 120 }
  validates :price, presence: true, if: Proc.new{ |p| p.price > 0 && p.price < 1000000 }
end

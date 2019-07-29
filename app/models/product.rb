class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, uniqueness: true, length: { maximum: 120 }
  validates :price, presence: true, numericality: {greater_than: 0, less_than: 1_000_000}
  validates :category_id, presence: true, numericality: {greater_than: 0, less_than: 100}
end

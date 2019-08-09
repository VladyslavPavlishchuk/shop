class Product < ApplicationRecord
  belongs_to :category
  has_many :ordered_products
  has_many :discounts, as: :discounted
  mount_uploader :image, ImageUploader
  validates :name, presence: true, uniqueness: true, length: { maximum: 120 }
  validates :price, presence: true, numericality: {greater_than: 0, less_than: 1_000_000}
end

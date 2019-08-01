class Product < ApplicationRecord
  belongs_to :category

  mount_uploader :image, ImageUploader
  validates_presence_of :image
  validates :name, presence: true, uniqueness: true, length: { maximum: 120 }
  validates :price, presence: true, numericality: {greater_than: 0, less_than: 1_000_000}
end

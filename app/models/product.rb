# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_many :ordered_products
  has_many :discounts, as: :discounted
  mount_uploader :image, ImageUploader
  validates :name, presence: true, uniqueness: true, length: { maximum: 120 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 1_000_000 }

  ransacker :image_filter, formatter: proc{|val|
    if val
      Product.all.select{|product| product['image'] != nil }.map(&:id)
    end
  } do |parent|
    parent.table[:id]
  end
end

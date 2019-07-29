class Category < ApplicationRecord
  has_many :products
  has_many :users

  validates :name, presence: true, uniqueness: true, length: { maximum: 60 }
  validates :priority, presence: true, numericality: {greater_than: 0, less_than: 100}
end

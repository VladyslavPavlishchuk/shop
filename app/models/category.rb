class Category < ApplicationRecord
  has_many :products
  has_many :users

  validates :name, presence: true, uniqueness: true, length: { maximum: 60 }
end

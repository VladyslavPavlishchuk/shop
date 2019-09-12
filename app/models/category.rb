# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products
  has_many :users
  has_many :discounts, as: :discounted

  validates :name, presence: true, uniqueness: true, length: { maximum: 60 }
end

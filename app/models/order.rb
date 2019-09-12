# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :ordered_products
  has_many :products, through: :ordered_products
  accepts_nested_attributes_for :ordered_products, allow_destroy: true
  enum status: [ :cart, :submitted, :confirmed, :completed, :canceled ]
end

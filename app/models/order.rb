class Order < ApplicationRecord
  belongs_to :user
  enum status: [ :cart, :submitted, :confirmed, :completed, :canceled ]
end

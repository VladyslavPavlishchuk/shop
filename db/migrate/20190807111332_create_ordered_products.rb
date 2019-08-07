class CreateOrderedProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :ordered_products do |t|
      t.references :order_id, foreign_key: true
      t.references :product_id, foreign_key: true
      t.references :discount_id, foreign_key: true
      t.integer :quontity
      t.integer :price

      t.timestamps
    end
  end
end

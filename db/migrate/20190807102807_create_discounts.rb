class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.integer :amount_type
      t.integer :amount
      t.integer :discount_type
      t.integer :target_id

      t.timestamps
    end
  end
end

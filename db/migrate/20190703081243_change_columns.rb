class ChangeColumns < ActiveRecord::Migration[5.2]
  def change
      change_column :products, :price, :decimal, precision: 2
      change_column :categories, :name, :string, uniqueness: true
      change_column :products, :name, :string, uniqueness: true
      change_column :users, :email, :string, uniqueness: true
      change_column_default :categories, :priority, 10
  end
end

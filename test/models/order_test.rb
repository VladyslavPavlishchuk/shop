# frozen_string_literal: true

require "test_helper"

class OrderTest < ActiveSupport::TestCase

  test "should create order" do
    assert @order.present?
  end

  test "should return nil discount" do
    assert_nil Order::CalculateDiscount.(product_id:@product.id, user_id:@order.id)["max_discount"]
  end

  test "should return product discount" do
    discount1 = create(:discount, :product_discount, discounted: @product)
    assert_equal Order::CalculateDiscount.(product_id:@product.id, user_id:@order.user.id)["max_discount"], discount1.id
  end

  test "should return user discount" do
    discount2 = create(:discount, :user_discount, discounted: @order.user)
    assert_equal Order::CalculateDiscount.(product_id:@product.id, user_id:@order.user.id)["max_discount"], discount2.id
  end

  test "should return category disount" do
    discount3 = create(:discount, :category_discount, discounted: @product.category)
    assert_equal Order::CalculateDiscount.(product_id:@product.id, user_id:@order.user.id)["max_discount"], discount3.id
  end
end

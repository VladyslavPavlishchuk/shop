# frozen_string_literal: true

class OrdersController < ApplicationController
  def show
    order = Order.find_by(user_id: current_user[:id], status: :cart)
    if order
      @order = order
      @ordered_products = @products = @order.ordered_products
      @products = @order.ordered_products.map { |ordered_product| ordered_product.product }
      @discounts = @ordered_products.map { |ordered_product| ordered_product.discount }
    end
  end

  def index
    @orders = Order.all
  end

  def delete
    Order.find(params[:order_id]).delete
    redirect_to :root
  end

  def create
    order = Order.find_or_create_by(user_id: params[:id], status: :cart)
    OrderedProduct.create(order_id: order.id,
                          product_id: params[:product_id],
                          discount_id: Order::CalculateDiscount.(product_id: params[:product_id],
                              user_id: params[:id])["max_discount"],
                          quontity: 1,
                          price: Product.find(params[:product_id]).price)
  end

  def remove_ordered_product
    OrderedProduct.delete(params[:id])
  end

  def submit
    order = Order.find(params[:order_id])
    order.update(status: :submitted)
    order.ordered_products.each_with_index { |product, i|
      product.update(quontity: params[:quontities][i])}
    redirect_to :root
  end
end

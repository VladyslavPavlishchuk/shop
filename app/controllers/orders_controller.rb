class OrdersController < ApplicationController
  def show
    p params
    order = Order.find_by(user_id: params[:user_id], status: :cart)
    @ordered_products = order.ordered_products
  end

  def create
    order = Order.find_or_create_by(user_id: params[:id], status: :cart)
    OrderedProduct.create(order_id: order.id, product_id: params[:product_id], discount_id: nil, quontity:1, price: Product.find(params[:product_id]).price)
  end
end

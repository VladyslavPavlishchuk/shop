class OrdersController < ApplicationController
  def show
    order = Order.find_by(user_id: current_user[:id], status: :cart)
    if order
      @ordered_products = order.ordered_products
      @products = @ordered_products.map { |ordered_product| ordered_product.product }
    else
      @rendered_products = nil
    end
  end

  def create
    order = Order.find_or_create_by(user_id: params[:id], status: :cart)
    OrderedProduct.create(order_id: order.id, product_id: params[:product_id], discount_id: nil, quontity:1, price: Product.find(params[:product_id]).price)
  end
end

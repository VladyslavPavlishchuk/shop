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
    OrderedProduct.create(order_id: order.id, product_id: params[:product_id], discount_id: get_discount(params[:product_id], params[:id]), quontity:1, price: Product.find(params[:product_id]).price)
  end


  def remove_ordered_product
    OrderedProduct.delete(params[:id])
  end

  def get_discount(product_id, user_id)
    product_discount = Discount.find_by(discounted_type: :product, discounted_id: product_id)
    user_discount = Discount.find_by(discounted_type: :user, discounted_id: user_id)
    category_discount = Discount.find_by(discounted_type: :category, discounted_id: :product_id)

    if product_discount||user_discount||category_discount
      choose_max_discount(Product.find(product_id),product_discount,user_discount,category_discount)
    else
      nil
    end
  end

    def choose_max_discount(product, *discounts)
      max_discount = 0
      discounts.each_with_index do |discount,i|
        discount_size = get_discount_size(product,discount)
        if i==0
          max=discount_size
          max_discount = discount
        else
          if discount_size > max
            max = discount_size
            max_discount = discount
          end
        end
      end
      max_discount
    end

    def get_discount_size(product, discount)
      if discount.amount_type == :percent
        product.price / 100 * discount.amount
      elsif discount.amount_type == :fixed
        discount.amount
      end
    end

end

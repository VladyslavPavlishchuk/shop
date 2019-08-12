class OrdersController < ApplicationController
  def show
    order = Order.find_by(user_id: current_user[:id], status: :cart)
    if order
      @ordered = order
      @products = @ordered.ordered_products.map { |ordered_product| ordered_product.product }
    else
      @rendered_products = nil
    end
  end

  def index
    @orders = Order.all
  end

  def delete
    Order.find(params[:order_id]).delete
  end

  def create
    order = Order.find_or_create_by(user_id: params[:id], status: :cart)
    OrderedProduct.create(order_id: order.id, product_id: params[:product_id], discount_id: get_discount(params[:product_id], params[:id]), quontity:1, price: Product.find(params[:product_id]).price)
  end

  def remove_ordered_product
    OrderedProduct.delete(params[:id])
  end

  def submit
    order = Order.find(params[:order_id])
    order.update(status: :submitted)
    order.ordered_products.each_with_index { |product, i|
      product.update(quontity: params[:quontities][i])}
  end

  def get_discount(product_id, user_id)
    product_discount = Discount.find_by(discounted_type: "Product", discounted_id: product_id)
    user_discount = Discount.find_by(discounted_type: "User", discounted_id: user_id)
    category_discount = Discount.find_by(discounted_type: "Category", discounted_id: Product.find(product_id).category)

    if product_discount||user_discount||category_discount
      choose_max_discount(Product.find(product_id),product_discount,user_discount,category_discount)[0].id
    else
      nil
    end
  end

    def choose_max_discount(product, *discounts)
      discounts.compact.each_with_index do |discount,i|
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
    end

    def get_discount_size(product, discount)
      if discount.amount_type == :percent
        product.price / 100 * discount.amount
      elsif discount.amount_type == :fixed
        discount.amount
      end
    end

end

# frozen_string_literal: true

class Order::CalculateDiscount < Trailblazer::Operation
  step :get_discount

  def get_discount(options, params, **)
    product_discount = Discount.find_by(discounted_type: "Product", discounted_id: params[:product_id])
    user_discount = Discount.find_by(discounted_type: "User", discounted_id: params[:user_id])
    category_discount = Discount.find_by(discounted_type: "Category", discounted_id: Product.find(params[:product_id]).category)

    if product_discount||user_discount||category_discount
      options["max_discount"] = choose_max_discount(Product.find(params[:product_id]), product_discount, user_discount, category_discount)[0].id
    else
      nil
    end
  end

  def choose_max_discount(product, *discounts)
    discounts.compact.each_with_index do |discount, i|
      discount_size = get_discount_size(product, discount)
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

    if discount.amount_type == "percent"
      product.price / 100 * discount.amount
    elsif discount.amount_type == "fixed"
      discount.amount
    end
  end
end

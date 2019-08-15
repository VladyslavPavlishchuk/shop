class OrderedProduct::CalculateFinalPrice < Trailblazer::Operation
  step :get_price

  def get_price(options, params, **)
    if params[:ordered_product].discount
      if params[:ordered_product].discount.amount_type == "percent"
        options["final_price"] = params[:ordered_product].price * params[:ordered_product].quontity - params[:ordered_product].price.to_f / 100 * params[:ordered_product].discount.amount
      else
        options["final_price"] = params[:ordered_product].price * params[:ordered_product].quontity - params[:ordered_product].discount.amount
      end
    else
      options["final_price"] = params[:ordered_product].price * params[:ordered_product].quontity
    end
  end
end

class DiscountsController < ApplicationController
  def create
    Discount.create(amount_type: params[:amount_type], amount: params[:amount], discounted_type: params[:discounted_type], discounted_id: params[:discounted_id])
  end

  def index
    @discounts = Discount.all
  end

  def show
    @discount = Discount.find(params[:id])
  end
end

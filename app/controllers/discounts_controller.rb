class DiscountsController < ApplicationController
  def create
    Discount.create(params)
  end

  def index
    Discount.all
  end

  def show
    Discount.find(params[:id])
  end
end

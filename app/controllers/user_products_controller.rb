# frozen_string_literal: true

class UserProductsController < ApplicationController
  def show
  end

  def filter
  end

  def to_cart
  end

  def index
    respond_to do |format|
      format.html { render partial: "shared/product_card",  locals: { products: Category.find(params[:id]).products.order(:id).page(params[:page]) } }
      format.js { render json: { products: Category.find(params[:id]).products } }
    end
  end
end

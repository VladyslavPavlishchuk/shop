class PagesController < ApplicationController
  def index
    @categories = Category.all
    @products = Category.first.products.order(:id).page(params[:page]).per(8)
  end
end

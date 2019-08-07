class PagesController < ApplicationController
  def index
    @categories = Category.all
    @products = Category.first.products.order(:id).page(params[:page]).per(8)

    respond_to do |format|
      format.html
      format.json {render json: {products: Category.find(params[:id]).products.order(:id).page(params[:page])}}
      format.js {render json: {products: Category.find(params[:id]).products.order(:id).page(params[:page])}}
    end
  end
end

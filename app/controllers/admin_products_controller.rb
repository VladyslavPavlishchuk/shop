class AdminProductsController < ApplicationController
  def show

    respond_to do |format|
      format.js
      format.html {@products = Product.all}
      format.json {}
    end
  end

  def create
    Product.create(params.permit(:name, :price, :description, :category_id))
    respond_to do |format|
      format.js
      format.json {head :ok}
    end
  end

  def delete
    Product.all.find(params[:id]).destroy

    respond_to do |format|
      format.js
      format.json {head :no_content;
      }
    end
  end

  def change
  end
end

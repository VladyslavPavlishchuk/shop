class AdminProductsController < ApplicationController
  def show
    new = Product.order("created_at").last
    @products = Product.all
    respond_to do |format|
      msg = {id: new.id, name: new.name, price: new.price,
             description: new.description, category_id: new.category_id}
      format.js {render json: msg}
      format.html
      format.json {response json: msg}
    end
  end

  def create
    created = Product.create(params.permit(:name, :price, :description, :category_id))
    respond_to do |format|
      if created.errors.any?
        format.js{ render json: {errors: created.errors}, status: :not_acceptable }
      else
        format.js { head :ok;}
      end
      format.json {head :ok}
    end
  end

  def delete
    Product.all.find(params[:id]).destroy

    respond_to do |format|
      format.js
      format.json {head :ok;
      }
    end
  end

  def update
   updated = Product.update(params[:id],{name: params[:name], price: params[:price],
                                           description: params[:description], category_id: params[:category_id]})
   respond_to do |format|
      if updated.errors.any?
        format.js{ render json: {errors: updated.errors}, status: :not_acceptable }
      else
        format.js { head :ok;}
      end
      format.json { head :ok;}
    end
  end
end

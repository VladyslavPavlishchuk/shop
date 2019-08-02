class AdminProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.js {render json: @product}
      format.json {render json: @product}
      format.html
    end
  end

  def newest
    new = Product.order("created_at").last
    respond_to do |format|
      msg = {id: new.id, name: new.name, price: new.price, description: new.description, category_id: new.category_id, image: new.image}
      format.js {render json: msg}
      format.html
      format.json {response json: msg}
    end
  end

  def create
    p params
    created = Product.new(params.permit(:name, :price, :category_id, :description, :image))
    created.save!
    respond_to do |format|
      if created.errors.any?
        format.js{ render json: {errors: created.errors}, status: :not_acceptable }
      else
        format.js { render json: created, status: :created}
      end
      format.json {head :created}
    end
  end

  def delete
    for_delete = Product.find_by id: params[:id]
    if for_delete == nil
      p for_delete.errors.add(:id, "not found")
    else
      for_delete.destroy
    end
    respond_to do |format|
      if for_delete.errors.any?
        format.js{ render json: {errors: for_delete.errors}, status: :not_acceptable }
      else
        format.js {head :no_content}
      end
      format.json {head :no_content}
    end
  end

  def update
    p params
    updated = Product.update(params[:id],{name: params[:name], price: params[:price],
                                                      category_id: params[:category_id], description: params[:description],
                                                      image: params[:image]})
    respond_to do |format|
      if updated.errors.any?
        format.js{ render json: {errors: updated.errors}, status: :not_acceptable }
      else
        format.js { render json: updated, status: :ok;}
      end
      format.json { head :ok;}
    end
  end
end

class AdminCategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def newest
    new = Category.order("created_at").last
    respond_to do |format|
      msg = {id: new.id, name: new.name, priority: new.priority}
      format.js {render json: msg}
      format.html
      format.json {response json: msg}
    end
  end

  def create
    created = Category.new(params.permit(:name, :priority))
    created.save
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
    for_delete = Category.find_by id: params[:id]
    p params
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
    updated = Category.update(params[:id],{name: params[:name], priority: params[:priority]})
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


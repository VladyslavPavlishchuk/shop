class AdminCategoriesController < ApplicationController
  def show
    @categories = Category.all
    new = Category.order("created_at").last
    respond_to do |format|
      msg = {id: new.id, name: new.name, priority: new.priority}
      format.js {render json: msg}
      format.html
      format.json {response json: msg}
    end
  end

  def create
    created = Category.create(params.permit(:name, :priority))
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
    Category.all.find(params[:id]).destroy

    respond_to do |format|
      format.js
      format.json {head :ok;
      }
    end
  end

  def update
    updated = Category.update(params[:id],{name: params[:name], priority: params[:priority]})
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

class AdminCategoriesController < ApplicationController
  def show
    #show should always find single record by its id, not show 'latest' record,
    # you should add custom controller action + route for this, e.g 'get_newest'
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
        # Create has separate http response code - 201.
        # Also, it's good idea to return json with created object, in order for frontend to render actual data.
        format.js { head :ok;}
      end
      format.json {head :ok}
    end
  end

  def delete
    # No need to use 'all' part.
    # What'll happen if there's no category with such id?
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
        # Return json with created object, in order for frontend to render actual data.
        format.js { head :ok;}
      end
      format.json { head :ok;}
    end
  end
end

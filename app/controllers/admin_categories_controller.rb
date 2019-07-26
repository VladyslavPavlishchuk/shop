class AdminCategoriesController < ApplicationController
  def show
    @categories = Category.all
  end

  def create
  end

  def destroy
  end

  def change
  end
end

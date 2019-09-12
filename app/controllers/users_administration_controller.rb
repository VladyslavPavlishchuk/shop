# frozen_string_literal: true

class UsersAdministrationController < ApplicationController
  def index
    @users = User.all
  end

  def update
    User.update(params[:id], name: params[:name], email: params[:email], role: params[:role])
    redirect_to "users_administration#index"
  end
end

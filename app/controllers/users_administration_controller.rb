class UsersAdministrationController < ApplicationController

  def show
    @users = User.all
  end

  def edit
    User.update(params[:id], name: params[:name], email: params[:email], role: params[:role])
    redirect_to 'users_administration#show'
  end
end

class UsersAdministrationController < ApplicationController

  def show
    @users = User.all
  end

  def edit
    # edit should return form for editing, not update attributes in the database, there's update method for that
    User.update(params[:id], name: params[:name], email: params[:email], role: params[:role])
    redirect_to 'users_administration#show'
  end
end

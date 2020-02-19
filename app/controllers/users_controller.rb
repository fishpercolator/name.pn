class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    authorize @user
  end
end

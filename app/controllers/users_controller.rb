class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    authorize @user
    render layout: 'user_profile'
  end
end

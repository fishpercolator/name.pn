class Api::V1::UsersController < ApplicationController

  def show
    @user = User.friendly.find(params[:id])
    authorize @user
    render json: {personal_name: @user.personal_name}
  end

end

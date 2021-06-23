class Api::V1::UsersController < ApplicationController

  def show
    user = User.friendly.find(params[:id])
    authorize user
    render json: UserBlueprint.render(user)
  end

end

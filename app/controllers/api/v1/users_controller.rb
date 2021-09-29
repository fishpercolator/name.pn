class Api::V1::UsersController < Api::BaseController

  def show
    eroihr
    user = User.friendly.find(params[:id])
    authorize user
    render json: UserBlueprint.render(user)
  end

end

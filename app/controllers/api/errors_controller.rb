class Api::ErrorsController < Api::BaseController
  include ExceptionStatus

  skip_before_action :authenticate_client!
  skip_after_action :verify_authorized

  layout false

  def show
    render json: { error: status_name }, status: status_code
  end
end

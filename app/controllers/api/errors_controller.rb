class Api::ErrorsController < Api::BaseController
  include Gaffe::Errors
  
  skip_before_action :authenticate_client!
  skip_after_action :verify_authorized
  
  layout false
  
  def show
    output = { error: @rescue_response }
    render json: output, status: @status_code
  end
end

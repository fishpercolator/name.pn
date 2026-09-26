class ErrorsController < ApplicationController
  include Gaffe::Errors
  
  before_action :format_html

  skip_after_action :verify_authorized

  layout -> { Views::Layouts::Application }

  def show
    render error_view.new, status: @status_code
  end
  
  private
  
  def format_html
    request.format = :html
  end

  # Gaffe::Errors sets @rescue_response to the exception's rescue response, e.g. :not_found
  def error_view = "Views::Errors::#{@rescue_response.to_s.camelize}".safe_constantize || Views::Errors::InternalServerError
end

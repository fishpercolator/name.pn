class ErrorsController < ApplicationController
  include Gaffe::Errors
  
  before_action :format_html

  skip_after_action :verify_authorized

  layout -> { Views::Layouts::Application }
  
  private
  
  def format_html
    request.format = :html
  end
end

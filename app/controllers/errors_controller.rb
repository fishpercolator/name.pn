class ErrorsController < ApplicationController
  include Gaffe::Errors

  skip_after_action :verify_authorized

  layout 'application'
end

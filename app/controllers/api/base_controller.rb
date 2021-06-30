class Api::BaseController < ApplicationController
  
  rescue_from Pundit::NotAuthorizedError, with: :forbidden
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  before_action :authenticate_client!
  
  protected
  
  def append_info_to_payload(payload)
    super
    payload[:client_id] = current_client&.id
  end
  
  private
  
  def forbidden
    render status: :forbidden, json: {error: I18n.t('errors.not_authorized')}
  end
  
  def not_found(exc)
    render status: :not_found, json: {error: exc.message}
  end
  
end

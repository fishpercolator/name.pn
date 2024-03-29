class ApplicationController < ActionController::Base
  include Pundit::Authorization
  after_action :verify_authorized, except: :index, unless: :framework_controller?
  after_action :verify_policy_scoped, only: :index, unless: :framework_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_admin!
    if !current_user&.role_admin?
      sign_out
      flash.alert = t('errors.not_admin')
      redirect_to new_user_session_path
    end
  end

  protected

  def framework_controller?
    devise_controller? || kind_of?(ActiveAdmin::BaseController) || kind_of?(HighVoltage::PagesController)
  end
  
  def user_not_authorized
    flash[:alert] = t('errors.not_authorized')
    redirect_to(request.referrer || root_path)
  end
  
  def append_info_to_payload(payload)
    super
    payload[:user_id] = current_user&.id
  end
end

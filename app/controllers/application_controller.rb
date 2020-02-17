class ApplicationController < ActionController::Base
  def authenticate_admin!
    if !current_user&.role_admin?
      sign_out
      flash.alert = t('errors.not_admin')
      redirect_to new_user_session_path
    end
  end
  include Pundit
  after_action :verify_authorized, except: :index, unless: :framework_controller?
  after_action :verify_policy_scoped, only: :index, unless: :framework_controller?

  protected

  def framework_controller?
    devise_controller? || kind_of?(ActiveAdmin::BaseController)
  end
end

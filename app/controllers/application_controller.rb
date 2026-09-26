class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Phlexible::Rails::ActionController::ImplicitRender

  layout -> { Views::Layouts::Application }

  after_action :verify_authorized, except: :index, unless: :framework_controller?
  after_action :verify_policy_scoped, only: :index, unless: :framework_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def framework_controller?
    devise_controller? || kind_of?(ActiveAdmin::BaseController) || kind_of?(HighVoltage::StaticPage)
  end
  
  def user_not_authorized(_exception = nil)
    flash[:alert] = t('errors.not_authorized')
    redirect_to(request.referrer || root_path)
  end
  
  def append_info_to_payload(payload)
    super
    payload[:user_id] = current_user&.id
  end

  private

  def phlex_view_path(action) = "views/#{controller_path}/#{action}"
end

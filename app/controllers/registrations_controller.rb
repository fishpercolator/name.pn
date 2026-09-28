class RegistrationsController < Devise::RegistrationsController
  rate_limit to: 10, within: 3.minutes, only: :create
  invisible_captcha only: :create, honeypot: :website, scope: :user, on_timestamp_spam: :reject_as_bot
  before_action :reject_as_bot, only: :create, unless: :cloudflare_turnstile_ok?
  before_action :configure_permitted_parameters
  before_action :setup_clients, only: %w[edit update]

  def edit
    render_plex_view(action: :edit)
  end

  protected

  def after_sign_up_path_for(resource)
    profile_index_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i[terms subscribe_to_mailing_list]
  end

  def phlex_view_path(action) = "views/devise/registrations/#{action}"

  def setup_clients
    @clients = policy_scope(resource.clients)
    @new_client = resource.clients.new
    @new_key = flash[:new_key]
  end

  private

  def reject_as_bot
    set_flash_message! :alert, :human_check_failed
    redirect_to new_user_registration_path
  end
end

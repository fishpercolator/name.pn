class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  
  protected

  def after_sign_up_path_for(resource)
    profile_index_path
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i[subscribe_to_mailing_list]
  end
end

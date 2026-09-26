class Components::Base < Phlex::HTML
  include Components::Daisy
  include Components::UI
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::T

  register_value_helper :current_user
  register_value_helper :user_signed_in?
end

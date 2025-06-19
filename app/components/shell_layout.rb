# frozen_string_literal: true

class Components::ShellLayout < Components::Layout
  register_value_helper :user_signed_in?
  register_value_helper :current_user

  def view_template
    super do
      PageHeader do |header|
        header.main_link(page_path('about')) { t('.about') }
        if user_signed_in?
          header.action_link(admin_root_path) { t('.admin') } if current_user.role_admin?
          header.action_link(edit_user_registration_path) { t('devise.registrations.edit.title') }
          header.action_link(destroy_user_session_path, data: {turbo_method: :delete}) { t('devise.sessions.destroy.title') }
        else
          header.action_link(new_user_session_path) { t('devise.sessions.new.title') }
          header.action_link(new_user_registration_path) { t('devise.registrations.new.title') }
        end
      end
      main do
        div(class: 'px-2 sm:px-4 sm:container py-4 sm:py-8') do
          yield
        end
      end
    end
  end

  def html_class
    'scroll-pt-15'
  end
end

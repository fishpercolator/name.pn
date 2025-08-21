# frozen_string_literal: true

class Views::Devise::Registrations::New < Views::Devise::Base
  def view_template
    CenteredForm do |cf|
      cf.title { title t('devise.registrations.new.title') }
      form_for(resource, as: resource_name, url: user_registration_path, builder: RuiFormBuilder) do |f|
        cf.section do
          FormField do
            f.label :email, t('devise.registrations.new.email')
            f.email_field :email, autofocus: true, autocomplete: 'email'
            f.errors :email
            FormFieldHint { t('devise.registrations.new.email_hint') }
          end
          FormField do
            f.label :password, t('devise.registrations.new.password')
            f.password_field :password, autocomplete: 'new-password'
            f.errors :password
          end
          FormField do
            f.label :password_confirmation
            f.password_field :password_confirmation, autocomplete: 'new-password'
            f.errors :password_confirmation
          end
        end
        cf.footer do
          f.submit t('devise.registrations.new.submit')
        end
      end
    end
  end
end

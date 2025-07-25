# frozen_string_literal: true

class RegistrationForm < ApplicationForm
  def view_template(&)
    row field(:email).input
    row field(:password).input(type: :password)
    row field(:password_confirmation).input(type: :password)
    submit t('devise.registrations.new.submit')
  end
end

# frozen_string_literal: true

class RegistrationForm < ApplicationForm
  attr_reader :cf

  def initialize(*, **)
    super
    @cf = @attributes.delete(:cf) # CenteredForm
  end

  def view_template(&)
    cf.section do
      row field(:email).input
      row field(:password).input(type: :password)
      row field(:password_confirmation).input(type: :password)
    end
    cf.footer do
      submit t('devise.registrations.new.submit')
    end
  end
end

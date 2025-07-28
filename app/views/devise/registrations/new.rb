# frozen_string_literal: true

class Views::Devise::Registrations::New < Views::Base
  def initialize(resource:)
    @resource = resource
  end

  def view_template
    CenteredForm do |cf|
      cf.title { title t('devise.registrations.new.title') }
      render RegistrationForm.new(@resource, cf:)
    end
  end
end

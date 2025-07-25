# frozen_string_literal: true

class SessionForm < ApplicationForm
  def view_template(&)
    row field(:email).input
    row field(:password).input(type: :password)
    render field(:remember_me).checkbox
    submit t('devise.sessions.new.submit')
  end
end

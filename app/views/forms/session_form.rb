# frozen_string_literal: true

class SessionForm < ApplicationForm
  attr_reader :cf

  def initialize(*, **)
    super
    @cf = @attributes.delete(:cf) # CenteredForm
  end

  def view_template(&)
    cf.section do
      row field(:email).input
      row field(:password).input(type: :password)
      render field(:remember_me).checkbox
    end
    cf.footer do
      submit t('devise.sessions.new.submit')
    end
  end
end

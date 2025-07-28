# frozen_string_literal: true

class Views::Devise::Sessions::New < Views::Base
  def initialize(resource:)
    @resource = resource
  end

  def view_template
    CenteredForm do |cf|
      cf.title { title t('devise.sessions.new.title') }
      cf.section { render SessionForm.new(@resource) }
    end
  end
end

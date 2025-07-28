# frozen_string_literal: true

class Views::Devise::Sessions::New < Views::Base
  include Phlex::Rails::Helpers::FormFor

  attr_reader :resource, :resource_name

  def initialize(resource:, resource_name:)
    @resource = resource
    @resource_name = resource_name
  end

  def view_template
    CenteredForm do |cf|
      cf.title { title t('devise.sessions.new.title') }
      form_for(resource, as: resource_name, url: user_session_path, builder: RuiFormBuilder) do |f|
        cf.section do
          FormField do
            f.label :email
            f.email_field :email, autofocus: true, autocomplete: 'email'
          end
          FormField do
            f.label :password
            f.password_field :password, autocomplete: 'current-password'
          end
          f.labelled_checkbox :remember_me
        end
        cf.footer do
          f.submit t('devise.sessions.new.submit')
        end
      end
    end
  end
end

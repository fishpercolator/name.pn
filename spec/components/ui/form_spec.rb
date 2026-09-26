require 'rails_helper'

RSpec.describe Components::UI::Form do
  def render_form(model, &fields)
    view = stub_const('FormSpecView', Class.new(Components::Base) do
      define_method(:view_template) { Form(model:, url: '/', &fields) }
    end)
    Capybara.string(ApplicationController.render(view.new, layout: false))
  end

  it 'takes labels and hints from the helpers translations' do
    form = render_form(User.new) { it.checkbox :subscribe_to_mailing_list }
    expect(form).to have_field(I18n.t('helpers.label.user.subscribe_to_mailing_list'))
    expect(form).to have_text(I18n.t('helpers.hint.user.subscribe_to_mailing_list'))
  end
end

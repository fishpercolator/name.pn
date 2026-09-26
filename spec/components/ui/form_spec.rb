require 'rails_helper'

RSpec.describe Components::UI::Form do
  def render_form(model, &fields)
    view = stub_const('FormSpecView', Class.new(Components::Base) do
      define_method(:view_template) { Form(model:, url: '/', &fields) }
    end)
    ApplicationController.render(view.new, layout: false)
  end

  it 'takes labels and hints from the helpers translations' do
    form = Capybara.string(render_form(User.new) { it.checkbox :subscribe_to_mailing_list })
    expect(form).to have_field(I18n.t('helpers.label.user.subscribe_to_mailing_list'))
    expect(form).to have_text(I18n.t('helpers.hint.user.subscribe_to_mailing_list'))
  end

  describe 'nested rows' do
    let(:user) { create(:user, :basic_profile).tap { create :link, user: it, title: 'Mastodon' } }
    let(:html) do
      render_form(user) do |form|
        form.nested(:links, add: 'Add a link') do |link|
          link.field :title
          link.field :url
        end
      end
    end
    let(:form) { Capybara.string(html) }

    it 'names existing rows with their index' do
      expect(form).to have_field('user[links_attributes][0][title]', with: 'Mastodon')
      expect(form).to have_field('user[links_attributes][0][_destroy]', type: :hidden)
    end

    it 'renders a template row for new records' do
      template = html[%r{<template data-nested-form-target="template">.*?</template>}m]
      expect(template).to include('name="user[links_attributes][NEW_RECORD][url]"')
    end

    it 'looks up hints for nested attributes under the parent model' do
      expect(form).to have_text(I18n.t('helpers.hint.user.links.url'))
    end
  end
end

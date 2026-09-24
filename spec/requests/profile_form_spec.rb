require 'rails_helper'

RSpec.describe 'Profile wizard forms', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create :user, :basic_profile }
  let(:page) { Capybara.string(response.body) }

  before do
    create :link, user:, title: 'Mastodon'
    sign_in user
    get profile_path(:links)
  end

  it 'names existing nested rows with their index' do
    expect(page).to have_field('user[links_attributes][0][title]', with: 'Mastodon')
    expect(page).to have_field('user[links_attributes][0][_destroy]', type: :hidden)
  end

  it 'renders a template row for new records' do
    template = response.body[%r{<template data-nested-form-target="template">.*?</template>}m]
    expect(template).to include('name="user[links_attributes][NEW_RECORD][url]"')
  end

  it 'looks up hints for nested attributes under the parent model' do
    expect(page).to have_text(I18n.t('helpers.hint.user.links.url'))
  end
end

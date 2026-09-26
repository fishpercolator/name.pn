require 'rails_helper'

RSpec.describe 'Smoke test', type: :request do
  describe 'content pages' do
    %w[about privacy terms guides/phonetic].each do |page|
      it "renders #{page}" do
        get page_path(page)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('page-title')
      end
    end
  end

  describe 'offline support' do
    it('renders the offline page') { get offline_path; expect(response).to have_http_status(:ok) }

    it 'renders a valid manifest' do
      get manifest_path(format: :json)
      expect(response.parsed_body).to include('name', 'icons')
    end

    it 'caches the offline page in the service worker' do
      get serviceworker_path(format: :js)
      expect(response.body).to include(offline_path)
      expect(response.body).not_to include('<html')
    end
  end

  describe 'admin' do
    let!(:user) { create :user, :full_profile, role: :admin }
    let!(:client) { create :client, user: }
    before { sign_in user }

    it('renders the dashboard') { get admin_root_path; expect(response).to have_http_status(:ok) }

    {
      users: -> { user }, pronoun_sets: -> { PronounSet.first }, links: -> { user.links.first },
      alternate_names: -> { user.alternate_names.first }, clients: -> { client }
    }.each do |resource, record|
      it "renders the #{resource} pages" do
        record = instance_exec(&record)
        get public_send("admin_#{resource}_path")
        expect(response).to have_http_status(:ok)
        get polymorphic_path([:admin, record])
        expect(response).to have_http_status(:ok)
        get edit_polymorphic_path([:admin, record]) if respond_to?("edit_admin_#{resource.to_s.singularize}_path")
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

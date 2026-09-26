require 'rails_helper'

RSpec.describe 'API keys', type: :request do
  let(:user) { create :user }
  before { sign_in user }

  it 'will not delete another user\'s key' do
    client = create :client
    delete client_path(client)
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq(I18n.t('errors.not_authorized'))
    expect(Client.exists?(client.id)).to be true
  end

  it 'will not create a key without a name' do
    post clients_path, params: {client: {name: ''}}
    expect(response).to redirect_to(edit_user_registration_path)
    expect(flash[:alert]).to include(Client.human_attribute_name(:name))
    expect(user.clients).to be_empty
  end
end

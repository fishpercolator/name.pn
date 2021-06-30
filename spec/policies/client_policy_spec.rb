require 'rails_helper'

RSpec.describe ClientPolicy, type: :policy do
  subject { described_class.new(user, client) }
  let!(:client) { create :client }
  
  let(:resolved_scope) do
    described_class::Scope.new(user, Client.all).resolve
  end

  context 'being anonymous' do
    let(:user) { nil }
    it { is_expected.to forbid_actions(%i[create show update destroy]) }
    it { expect(resolved_scope).to be_empty }
  end
  
  context 'being the user associated with this client' do
    let(:user) { client.user }
    it { is_expected.to permit_actions(%i[create destroy]) }
    it { is_expected.to permit_mass_assignment_of(%i[name]) }
    it { is_expected.not_to permit_mass_assignment_of(%i[user_id jti created_at]) }
    it { expect(resolved_scope).to include(client) }
  end
  
  context 'being another user' do
    let(:user) { create :user }
    it { is_expected.to forbid_actions(%i[create show update destroy]) }
    it { expect(resolved_scope).to be_empty }
  end

end

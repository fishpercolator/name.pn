require 'rails_helper'

RSpec.describe Admin::ApplicationPolicy, type: :policy do
  subject { described_class.new(user, user_obj) }
  let!(:record) { create :pronoun_set } # could be any record type

  subject { described_class.new(user, record) }

  let(:resolved_scope) do
    described_class::Scope.new(user, PronounSet.all).resolve
  end

  context 'being anonymous' do
    let(:user) { nil }
    it { is_expected.to forbid_actions(%i[index create show update destroy]) }
    it { expect(resolved_scope).to be_empty }
  end
  
  context 'being a normal user' do
    let(:user) { create :user }
    it { is_expected.to forbid_actions(%i[index create show update destroy]) }
    it { expect(resolved_scope).to be_empty }
  end
  
  context 'being an admin user' do
    let(:user) { create :user, role: :admin }
    it { is_expected.to permit_actions(%i[index create show update destroy]) }
    it { expect(resolved_scope).to include(record) }
  end
end

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new(user, user_obj) }
  let!(:user_obj) { create :user, :basic_profile }
  
  context 'being anonymous' do
    let(:user) { nil }
    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[update]) }
    context 'profile not complete' do
      let(:user_obj) { create :user }
      it { is_expected.to forbid_actions(%i[show update]) }
    end
  end
  
  context 'being a normal user' do
    let(:user) { create :user }
    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[update]) }
    context 'profile not complete' do
      let(:user_obj) { create :user }
      it { is_expected.to forbid_actions(%i[show update]) }
    end
  end
  
  context 'being the actual user' do
    let(:user) { user_obj }
    it { is_expected.to permit_actions(%i[show update]) }
    it { is_expected.to permit_mass_assignment_of([:full_name, :personal_name, :formal_name, :envelope_name, :phonetic, :slug, :pronoun_set_ids => []]) }
    context 'profile not complete' do
      let(:user_obj) { create :user }
      it { is_expected.to permit_actions(%i[update]) }
      it { is_expected.to forbid_actions(%i[show]) }
    end
  end
end

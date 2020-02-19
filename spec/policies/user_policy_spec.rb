require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new(user, user_obj) }
  let!(:user_obj) { create :user }
  
  context 'being anonymous' do
    let(:user) { nil }
    it { is_expected.to permit_actions(%i[show]) }
  end
  
  context 'being a normal user' do
    let(:user) { create :user }
    it { is_expected.to permit_actions(%i[show]) }
  end
end

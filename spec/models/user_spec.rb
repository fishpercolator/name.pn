require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe '#pronoun_sets_with_preference' do
    before do
      create :pronoun_set, :they
      create :pronoun_set, :he
      create :pronoun_set, :she
      create :pronoun_set, :it
    end
    let(:user) { create :user, :basic_profile }
    subject { user.pronoun_sets_with_preference }
    context 'no pronounless_style' do
      it 'returns the user-selected pronouns' do
        expect(subject).to have(1).item
        expect(subject.first.nominative).to eq('she')
      end
    end
    context 'pronounless_style is none' do
      before do
        user.update(pronounless_style: :none)
      end
      it 'returns only the user\'s name' do
        expect(subject).to have(1).item
        expect(subject.first.nominative).to eq('Audrey')
      end
    end
    context 'pronounless_style is unknown' do
      before do
        user.update(pronounless_style: :unknown)
      end
      it 'returns only the user\'s name' do
        expect(subject).to have(1).item
        expect(subject.first.nominative).to eq('Audrey')
      end
    end
    context 'pronounless_style is any' do
      before do
        user.update(pronounless_style: :any)
      end
      it 'returns 3 random pronoun sets' do
        expect(subject).to have(3).items
      end
    end
    context 'user has specified an order for pronouns' do
      before do
        user.user_pronoun_sets.destroy_all
        UserPronounSet.create!(user: user, pronoun_set: PronounSet.find_by(nominative: 'he'), position: 1)
        UserPronounSet.create!(user: user, pronoun_set: PronounSet.find_by(nominative: 'they'), position: 2)
        user.reload
      end
      it 'returns the pronoun sets in the correct order' do
        expect(subject.map(&:to_s)).to eq(%w[he/him they/them])
      end
    end
  end
end

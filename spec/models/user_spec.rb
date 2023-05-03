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

  describe '.basic_names_complete' do
    before do
      create :user
      create :user, full_name: '', personal_name: 'A'
      create :user, full_name: 'B', personal_name: ''
      create :user, full_name: 'C'
      create :user, personal_name: 'D'
      create :user, full_name: 'E', personal_name: 'F'
      create :user, full_name: 'G', personal_name: 'H'
    end

    it 'returns only those users with full_name and personal_name set to non-empty values' do
      expect(User.basic_names_complete).to have(2).items
      expect(User.basic_names_complete.pluck(:full_name).sort).to eq(%w[E G])
    end
  end

  describe '.has_pronouns' do
    before do
      create :user, full_name: 'A'
      create :user, full_name: 'B', pronoun_sets: [create(:pronoun_set, :she)]
      create :user, full_name: 'C', pronounless_style: 'none'
      create :user, full_name: 'D', pronounless_style: 'any'
      create :user, full_name: 'E', personal_name: 'F'
    end

    it 'returns only those users with either pronouns associated or a pronounless_style set' do
      expect(User.has_pronouns).to have(3).items
      expect(User.has_pronouns.pluck(:full_name).sort).to eq(%w[B C D])
    end
  end

  describe '.profile_complete' do
    before do
      create :user, full_name: 'A', personal_name: 'A'
      create :user, full_name: 'B', personal_name: 'B', pronoun_sets: [create(:pronoun_set, :she)]
      create :user, full_name: 'C', personal_name: 'C', pronounless_style: 'none'
      create(:user, full_name: 'D', personal_name: 'D', pronounless_style: 'any').then do |u|
        u.update_column(:slug, nil) # force slug to nil because UserSlug will set it automatically
      end
      create :user, full_name: 'E', personal_name: 'E'
      create :user, personal_name: 'F', pronoun_sets: [create(:pronoun_set, :she)]
    end

    it 'returns only those users with a complete profile (one that can be shared)' do
      expect(User.profile_complete).to have(2).items
      expect(User.profile_complete.pluck(:full_name).sort).to eq(%w[B C])
      # Check for parity with #profile_complete?
      expect(User.profile_complete).to all(be_profile_complete)
      expect((User.all - User.profile_complete).map(&:profile_complete?)).to all(eq false)
    end
  end

end

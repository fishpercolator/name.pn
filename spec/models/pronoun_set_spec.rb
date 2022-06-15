require 'rails_helper'

RSpec.describe PronounSet, type: :model do
  
  describe '#to_s' do
    context 'nominative/oblique different' do
      subject { create :pronoun_set }
      it 'shows nominative/oblique' do
        expect("#{subject}").to eq('they/them')
      end
    end
    context 'nominative/oblique the same' do
      subject { create :pronoun_set, :it }
      it 'shows nominative/possessive' do
        expect("#{subject}").to eq('it/its')
      end
    end
    context 'with user, pronoun_style two' do
      let(:user) { create :user }
      subject { create :pronoun_set }
      it 'shows nominative/oblique' do
        expect(subject.to_s user).to eq('they/them')
      end
    end
    context 'with user, pronoun_style three' do
      let(:user) { create :user, pronoun_style: :three }
      subject { create :pronoun_set }
      it 'shows nominative/oblique/possessive' do
        expect(subject.to_s user).to eq('they/them/theirs')
      end
    end
  end
  
end

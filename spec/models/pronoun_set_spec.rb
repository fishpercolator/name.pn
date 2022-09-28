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
    context 'name_only' do
      let(:user) { create :user, pronoun_style: :three }
      subject { PronounSet.name_only(user) }
      it 'says to use the name' do
        expect("#{subject}").to eq('Please always use my name')
      end
    end
  end
  
  describe '.name_only' do
    let(:user) { create :user, :basic_profile }
    subject { PronounSet.name_only(user) }
    it 'sets the name_only flag' do
      expect(subject.name_only).to be true
    end
    it 'sets everything to the user\'s name' do
      expect(subject.nominative).to eq('Audrey')
      expect(subject.oblique).to eq('Audrey')
      expect(subject.possessive_determiner).to eq('Audrey\'s')
      expect(subject.possessive).to eq('Audrey\'s')
      expect(subject.reflexive).to eq('Audrey')
      expect(subject.copula).to eq('is')
    end
  end
  
end

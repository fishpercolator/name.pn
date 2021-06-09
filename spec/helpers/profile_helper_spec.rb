require 'rails_helper'


RSpec.describe ProfileHelper, type: :helper do
  
  describe "#pronunciation_of_options" do
    context 'complete user' do
      let(:user) { create :user, full_name: 'Dale Cooper', personal_name: 'Dale', formal_name: 'Agent Cooper', envelope_name: 'Agt. Cooper' }
      it 'returns all the options' do
        expect(helper.pronunciation_of_options(user)).to eq([
          ['Dale Cooper', 'full_name'],
          ['Dale', 'personal_name'],
          ['Agent Cooper', 'formal_name'],
          ['Agt. Cooper', 'envelope_name']
        ])
      end
    end
    context 'partial/dup user' do
      let(:user) { create :user, full_name: 'BOB', personal_name: 'BOB', formal_name: '', envelope_name: '' }
      it 'returns only the unique options' do
        expect(helper.pronunciation_of_options(user)).to eq([
          ['BOB', 'full_name']
        ])
      end
    end
  end
  
end

require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'slug auto-populated' do
    it 'leaves slug blank until user supplies a full name' do
      u = create :user, full_name: ''
      expect(u.slug).to be nil
    end
    it 'uses full name if available' do
      u = create :user, full_name: 'Killer BOB'
      expect(u.slug).to eq('killer-bob')
    end
    it 'appends some spicy_proton if not available' do
      allow_any_instance_of(Spicy::Proton).to receive(:pair).and_return('crimefighting donut')
      create :user, full_name: 'Audrey Horne'
      u = create :user, full_name: 'Audrey Horne'
      expect(u.slug).to start_with('audrey-horne-crimefighting-donut')
    end
  end
  
  describe 'user overrides' do
    it 'allows unused name to be used' do
      u = create :user, :basic_profile
      u.slug = 'black-lodge'
      expect(u).to be_valid
      expect(u.slug).to eq('black-lodge')
    end
    it 'lowercases name if user tries uppercase' do
      u = create :user, :basic_profile
      u.slug = 'BLACK-Lodge'
      expect(u).to be_valid
      expect(u.slug).to eq('black-lodge')
    end
    it 'only allows letters, numbers and dashes' do
      u = build :user, :basic_profile
      u.slug = 'black!-lodge'
      expect(u).not_to be_valid
      u.slug = 'bl_ack-lodge'
      expect(u).not_to be_valid
      u.slug = 'black-lodge-12345'
      expect(u).to be_valid
    end
    it 'is invalid if not containing at least one dash and starting with a letter' do
      u = build :user, :basic_profile
      u.slug = '-black-lodge'
      expect(u).not_to be_valid
      u.slug = '123-dale-cooper'
      expect(u).not_to be_valid
      u.slug = 'blacklodge'
      expect(u).not_to be_valid
      u.slug = 'blacklodge-'
      expect(u).not_to be_valid
      u.slug = 'black-123-' # this one is valid
      expect(u).to be_valid
    end
    it 'marks as invalid but provides suggestion if used' do
      create :user, :basic_profile, full_name: 'Albert Rosenfield'
      u = build :user, :basic_profile, full_name: 'Audrey Horne'
      u.slug = 'albert-rosenfield'
      expect(u).not_to be_valid
      expect(u.errors.details).to eq({slug: [{error: :unavailable}]})
      expect(u.slug).to eq('audrey-horne')
    end
    it 'resolves collisions on suggestions' do
      allow_any_instance_of(Spicy::Proton).to receive(:pair).and_return('crimefighting donut')
      create :user, :basic_profile, full_name: 'Albert Rosenfield'
      create :user, :basic_profile, full_name: 'Audrey Horne'
      u = build :user, :basic_profile, full_name: 'Audrey Horne'
      u.slug = 'albert-rosenfield'
      expect(u).not_to be_valid
      expect(u.errors.details).to eq({slug: [{error: :unavailable}]})
      expect(u.slug).to eq('audrey-horne-crimefighting-donut')
    end
  end
  
end

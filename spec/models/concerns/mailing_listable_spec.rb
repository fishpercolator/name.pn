require 'rails_helper'

RSpec.describe MailingListable do
  let(:buttondown) { instance_double(Buttondown, subscribe!: nil) }
  before { allow(MailingListable).to receive(:buttondown).and_return(buttondown) }

  describe 'signing up' do
    it 'subscribes users who ask to be' do
      user = create :user, subscribe_to_mailing_list: true
      expect(buttondown).to have_received(:subscribe!).with(user.email, {})
    end

    it 'leaves everyone else alone' do
      create :user
      expect(buttondown).not_to have_received(:subscribe!)
    end
  end

  describe 'updating a subscriber' do
    let!(:user) { create :user, :basic_profile, email: 'audrey@example.com' }
    before { allow(buttondown).to receive(:subscribed?).and_return(true) }

    it 'sends a changed email along with the old one' do
      user.update!(email: 'audrey@greatnorthern.com')
      expect(buttondown).to have_received(:subscribed?).with('audrey@example.com')
      expect(buttondown).to have_received(:subscribe!)
        .with('audrey@greatnorthern.com', {'full_name' => 'Audrey Horne', 'email_was' => 'audrey@example.com'})
    end

    it 'sends a changed name' do
      user.update!(formal_name: 'Ms Horne')
      expect(buttondown).to have_received(:subscribe!)
        .with('audrey@example.com', {'full_name' => 'Audrey Horne', 'formal_name' => 'Ms Horne'})
    end

    it 'ignores changes Buttondown doesn\'t store' do
      user.update!(phonetic: 'AWD-ree')
      expect(buttondown).not_to have_received(:subscribe!)
    end
  end

  it 'ignores changes to non-subscribers' do
    user = create :user, :basic_profile
    allow(buttondown).to receive(:subscribed?).and_return(false)
    user.update!(full_name: 'Audrey Briggs')
    expect(buttondown).not_to have_received(:subscribe!)
  end

  context 'without a Buttondown API key' do
    let(:buttondown) { nil }

    it 'does nothing' do
      user = create :user, subscribe_to_mailing_list: true
      expect(user.subscribed_to_mailing_list?).to be_nil
      expect { user.unsubscribe_from_mailing_list! }.not_to raise_error
    end
  end
end

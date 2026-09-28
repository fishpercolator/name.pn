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

    context 'without a Buttondown API key' do
      let(:buttondown) { nil }

      it 'still creates the user' do
        expect { create :user, subscribe_to_mailing_list: true }.to change(User, :count).by(1)
      end
    end
  end

  describe 'updating a user' do
    let!(:user) { create :user, :basic_profile, email: 'audrey@example.com' }

    context 'who is subscribed' do
      before { allow(buttondown).to receive(:subscribed?).and_return(true) }

      it 'sends a changed email along with the old one' do
        user.update!(email: 'audrey@greatnorthern.example.com')
        expect(buttondown).to have_received(:subscribed?).with('audrey@example.com')
        expect(buttondown).to have_received(:subscribe!)
          .with('audrey@greatnorthern.example.com', {'full_name' => 'Audrey Horne', 'email_was' => 'audrey@example.com'})
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

    context 'who isn\'t subscribed' do
      before { allow(buttondown).to receive(:subscribed?).and_return(false) }

      it 'leaves them alone' do
        user.update!(full_name: 'Audrey Briggs')
        expect(buttondown).not_to have_received(:subscribe!)
      end
    end

    context 'without a Buttondown API key' do
      let(:buttondown) { nil }

      it 'still saves the change' do
        user.update!(email: 'audrey@greatnorthern.example.com')
        expect(user.reload.email).to eq('audrey@greatnorthern.example.com')
      end
    end
  end
end

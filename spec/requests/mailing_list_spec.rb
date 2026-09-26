require 'rails_helper'

RSpec.describe 'Mailing list', type: :request do
  let(:user) { create :user }
  let(:buttondown) { instance_double(Buttondown, subscribe!: nil, unsubscribe!: nil) }
  before do
    allow(MailingListable).to receive(:buttondown).and_return(buttondown)
    sign_in user
  end

  it 'subscribes and offers to unsubscribe' do
    allow(buttondown).to receive(:subscribed?).and_return(true)
    post users_mailing_list_subscribe_path
    expect(buttondown).to have_received(:subscribe!).with(user.email, anything)
    expect(response.body).to include(users_mailing_list_unsubscribe_path)
  end

  it 'unsubscribes and offers to subscribe' do
    allow(buttondown).to receive(:subscribed?).and_return(false)
    post users_mailing_list_unsubscribe_path
    expect(buttondown).to have_received(:unsubscribe!).with(user.email)
    expect(response.body).to include(users_mailing_list_subscribe_path)
  end
end

require 'rails_helper'

RSpec.describe Buttondown do
  before do
    # Dale already exists
    dale = {id: 1, email: 'dale@example.com', subscriber_type: 'regular', metadata: {first_name: 'Dale'}}
    stub_request(:get, "https://api.buttondown.email:443/v1/subscribers/dale%40example.com")
    .to_return(body: dale.to_json, headers: {content_type: 'application/json'})
    stub_request(:get, "https://api.buttondown.email:443/v1/subscribers/1")
    .to_return(body: dale.to_json, headers: {content_type: 'application/json'})
    # Laura has been deleted
    laura = {id: 2, email: 'laura@example.com', subscriber_type: 'unsubscribed', metadata: {first_name: 'Laura'}}
    stub_request(:get, "https://api.buttondown.email:443/v1/subscribers/laura%40example.com")
    .to_return(body: laura.to_json, headers: {content_type: 'application/json'})
    stub_request(:get, "https://api.buttondown.email:443/v1/subscribers/2")
    .to_return(body: laura.to_json, headers: {content_type: 'application/json'})
    # Gordon has never subscribed
    stub_request(:get, "https://api.buttondown.email:443/v1/subscribers/gordon%40example.com")
    .to_return(status: 404)
  end

  subject { described_class.new('xxxyyy') }

  describe '.new' do
    it { is_expected.to be_a Buttondown }
    it('sets the key') { expect(subject.key).to eq('xxxyyy') }
  end

  describe '#subscribed?' do
    it 'returns true for users that exist (email or id)' do
      expect(subject.subscribed? 'dale@example.com').to be true
      expect(subject.subscribed? 1).to be true
    end
    it 'returns false for users that have unsubscribed (email or id)' do
      expect(subject.subscribed? 'laura@example.com').to be false
      expect(subject.subscribed? 2).to be false
    end
    it 'returns false for users that have never subscribed' do
      expect(subject.subscribed? 'gordon@example.com').to be false
    end
  end

  describe 'subscribe!' do
    before do
      stub_request(:post, "https://api.buttondown.email:443/v1/subscribers")
      stub_request(:patch, "https://api.buttondown.email:443/v1/subscribers/1")
      stub_request(:patch, "https://api.buttondown.email:443/v1/subscribers/2")
    end
    it 'sends a post if user has never existed' do
      subject.subscribe! 'gordon@example.com'
      expect(
        a_request(:post, "https://api.buttondown.email:443/v1/subscribers")
        .with(
          headers: {Authorization: 'Token xxxyyy'},
          body: {email: 'gordon@example.com', subscriber_type: 'regular', metadata: {}}
        )
      ).to have_been_made.once
    end
    it 'sends a patch if user was unsubscribed' do
      subject.subscribe! 'laura@example.com'
      expect(
        a_request(:patch, "https://api.buttondown.email:443/v1/subscribers/2")
        .with(
          headers: {Authorization: 'Token xxxyyy'},
          body: {subscriber_type: 'regular', metadata: {}}
        )
      ).to have_been_made.once
    end
    it 'sends a metadata patch if user already exists' do
      subject.subscribe! 'dale@example.com', first_name: 'Dale'
      expect(
        a_request(:patch, "https://api.buttondown.email:443/v1/subscribers/1")
        .with(
          headers: {Authorization: 'Token xxxyyy'},
          body: {subscriber_type: 'regular', metadata: {first_name: 'Dale'}}
        )
      ).to have_been_made.once
    end
  end

  describe 'unsubscribe!' do
    before do
      stub_request(:delete, "https://api.buttondown.email:443/v1/subscribers/1")
    end
    it 'sends a delete' do
      subject.unsubscribe! 'dale@example.com'
      expect(
        a_request(:delete, "https://api.buttondown.email:443/v1/subscribers/1")
        .with(headers: {Authorization: 'Token xxxyyy'})
      ).to have_been_made.once
    end
  end

end

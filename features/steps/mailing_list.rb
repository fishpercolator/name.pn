class Spinach::Features::MailingList < Spinach::FeatureSteps
  include CommonSteps::Auth

  class FakeButtondown
    def initialize(subscribed) = @subscribed = subscribed
    def subscribed?(_email) = @subscribed
    def subscribe!(*) = @subscribed = true
    def unsubscribe!(_email) = @subscribed = false
  end

  step 'I am not subscribed to the mailing list' do
    allow(MailingListable).to receive(:buttondown).and_return(FakeButtondown.new(false))
  end

  step 'I am subscribed to the mailing list' do
    allow(MailingListable).to receive(:buttondown).and_return(FakeButtondown.new(true))
  end

  step 'I visit the account page' do
    visit edit_user_registration_path
  end

  step 'I click to subscribe to the mailing list' do
    click_on 'Subscribe to mailing list'
  end

  step 'I click to unsubscribe from the mailing list' do
    click_on 'Unsubscribe'
  end

  step 'I should see that I am subscribed' do
    expect(page).to have_content('Subscribed: You are currently subscribed to our mailing list')
  end

  step 'I should see that I am not subscribed' do
    expect(page).to have_content('Not subscribed: You are currently not subscribed to our mailing list')
  end
end

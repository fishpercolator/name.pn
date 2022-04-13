class Spinach::Features::CancelAccount < Spinach::FeatureSteps
  include CommonSteps::Auth

  step 'I visit the account page' do
    visit edit_user_registration_path
  end

  step 'I click to cancel my account and confirm the action' do
    accept_confirm { click_on 'Cancel your account' }
  end

  step 'my account should be deleted' do
    expect(User.find_by(email: 'testuser@example.com')).to be nil
  end

  step 'I should be signed out on the home page' do
    expect(page).to have_content('Your name – your rules')
  end

  step 'I should see a message confirming my account has gone' do
    expect(page).to have_content('Your account has been successfully cancelled.')
  end
end

class Spinach::Features::PasswordReset < Spinach::FeatureSteps
  include CommonSteps::Auth

  step 'I have previously created a user' do
    create :user, :test
  end

  step 'I visit the sign in page' do
    visit new_user_session_path
  end

  step 'I click the link for a lost password' do
    click_on 'Lost your password?'
  end

  step 'I ask for reset instructions for my email address' do
    fill_in 'Your email address', with: test_user.email
    click_button 'Send me password reset instructions'
  end

  step 'I should see a message saying the instructions are on their way' do
    expect(page).to have_content('You will receive an email with instructions on how to reset your password')
  end

  step 'I follow the link in the email I was sent' do
    open_email test_user.email
    visit_in_email 'Change my password'
  end

  step 'I choose a new password' do
    fill_in 'New password', with: 'wr4pped1nplast1c'
    fill_in 'Confirm new password', with: 'wr4pped1nplast1c'
    click_button 'Change my password'
  end

  step 'I should see a message telling me my password has changed' do
    expect(page).to have_content('Your password has been changed successfully')
  end

  step 'I should be able to use my new password' do
    expect(test_user.reload.valid_password?('wr4pped1nplast1c')).to be true
  end
end

class Spinach::Features::EditAccount < Spinach::FeatureSteps
  include CommonSteps::Auth

  step 'I visit the account page' do
    visit edit_user_registration_path
  end

  step 'I change my email address' do
    fill_in 'Your email address', with: 'audrey@greatnorthern.com'
  end

  step 'I choose a new password' do
    fill_in 'New password', with: 'wr4pped1nplast1c'
    fill_in 'Confirm password (type it again)', with: 'wr4pped1nplast1c'
  end

  step 'I enter my current password' do
    fill_in 'Current password', with: 'letmein123'
  end

  step 'I enter the wrong current password' do
    fill_in 'Current password', with: 'fire-walk-with-me'
  end

  step 'I save my account' do
    click_button 'Save'
  end

  step 'I should see a message telling me my account has been updated' do
    expect(page).to have_content('Your account has been updated successfully')
  end

  step 'my email address should have changed' do
    expect(User.find_by(email: 'audrey@greatnorthern.com')).to be_present
  end

  step 'my password should have changed' do
    expect(test_user.reload.valid_password?('wr4pped1nplast1c')).to be true
  end

  step 'I should see an error saying my current password is invalid' do
    expect(page).to have_content(/Current password\s*is invalid/)
  end

  step 'my email address should not have changed' do
    expect(test_user.reload.email).to eq('testuser@example.com')
  end
end

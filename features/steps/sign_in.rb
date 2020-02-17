class Spinach::Features::SignIn < Spinach::FeatureSteps
  include CommonSteps::Auth

  step 'I have previously created a user' do
    create :user, :test
  end

  step 'I visit the root path' do
    visit root_path
  end

  step 'I click to log in' do
    click_on 'Log in'
  end

  step 'I fill in my email address' do
    fill_in 'Email', with: test_user.email
  end

  step 'I fill in my password' do
    fill_in 'Password', with: 'letmein123'
  end

  step 'I submit the form' do
    click_button 'Log in'
  end

  step 'I should see a message telling me I have signed in' do
    expect(page).to have_content('Signed in successfully')
  end

  step 'I should see a link to edit my account' do
    expect(page).to have_content('My account')
  end

  step 'I click to sign out' do
    click_on 'Log out'
  end

  step 'I should see a message telling me I have signed out' do
    expect(page).to have_content('Signed out successfully')
  end

  step 'I should not see a link to edit my account' do
    expect(page).not_to have_content('My account')
  end

  step 'I click to close the message' do
    find('#messages .delete').click
  end

  step 'I should not see a message telling me I have signed in' do
    expect(page).not_to have_content('Signed in successfully')
  end
end

class Spinach::Features::SignupAndEditProfile < Spinach::FeatureSteps
  include CommonSteps::Auth

  step 'I visit the sign up page' do
    visit new_user_registration_path
  end

  step 'I fill in my email address and a password' do
    fill_in 'Your email address', with: 'loglady@example.com'
    fill_in 'Password', with: 'th4tn1ght'
    fill_in 'Password confirmation', with: 'th4tn1ght'
  end

  step 'I submit the form' do
    click_button 'Submit'
  end

  step 'I should be on the first page of the profile editor' do
    expect(page).to have_css('.profile-form h1', text: 'Your name')
  end

  step 'my account should have been created on the backend' do
    expect(User.find_by email: 'loglady@example.com').to be_a User
  end

  step 'I fill in my personal name details' do
    fill_in 'Your "full" name', with: 'Log Lady'
    fill_in 'Your personal name', with: 'Margaret'
  end

  step 'I go to the next stage' do
    click_button 'Next step'
  end

  step 'I fill in my formal name details' do
    fill_in 'Your envelope name', with: 'Mrs M. Lanterman'
    fill_in 'Your formal name', with: 'Mrs Lanterman'
  end

  step 'I fill in my pronunciation' do
    fill_in 'Phonetic pronunciation of \'Log Lady\'', with: 'LOG LAY-dee'
  end

  step 'I select my pronouns as she/her' do
    check 'she/her'
  end

  step 'I click to finish' do
    click_button 'Finish my profile'
  end

  step 'I should be on the dashboard' do
    expect(page).to have_css('h1', text: 'Your name dashboard')
  end

  step 'my profile should be completed successfully' do
    pending 'step not implemented'
  end

  step 'an Audrey Horne profile already exists' do
    pending 'step not implemented'
  end

  step 'I fill in audrey-horne as a slug' do
    pending 'step not implemented'
  end

  step 'I should still be on the slug-editing page' do
    pending 'step not implemented'
  end

  step 'I should see a message telling me there was a conflict' do
    pending 'step not implemented'
  end

  step 'I should see a suggested alternative name prefilled' do
    pending 'step not implemented'
  end

  step 'I click to save and exit' do
    pending 'step not implemented'
  end

  step 'my profile should be partially completed' do
    pending 'step not implemented'
  end

  step 'I visit the dashboard' do
    pending 'step not implemented'
  end

  step 'I click the edit button in the pronouns box' do
    pending 'step not implemented'
  end

  step 'I should be on the pronouns page of the profile editor' do
    pending 'step not implemented'
  end
end

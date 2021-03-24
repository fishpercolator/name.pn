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
  
  step 'I select the running example' do
    select 'Running', from: 'Pronoun example'
  end

  step 'I click to finish' do
    click_button 'Finish my profile'
  end

  step 'I should be on the dashboard' do
    expect(page).to have_css('h1', text: 'Your name dashboard')
  end

  step 'my profile should be completed successfully' do
    user = User.find_by(email: 'loglady@example.com')
    expect(user.personal_name).to eq('Margaret')
    expect(user.full_name).to eq('Log Lady')
    expect(user.formal_name).to eq('Mrs Lanterman')
    expect(user.envelope_name).to eq('Mrs M. Lanterman')
    expect(user.phonetic).to eq('LOG LAY-dee')
    expect(user).to be_pronoun_example_running
    expect(user.pronoun_sets.map(&:to_s)).to eq(['she/her'])
    expect(user.slug).to eq('log-lady')
  end

  step 'an Audrey Horne profile already exists' do
    create :user, full_name: 'Audrey Horne'
  end

  step 'I fill in audrey-horne as a slug' do
    fill_in id: 'user_slug', with: 'audrey-horne'
  end

  step 'I should still be on the slug-editing page' do
    expect(page).to have_css('h1', text: 'Your URL')
  end

  step 'I should see a message telling me there was a conflict' do
    expect(page).to have_content('That URL is already in use. Here is a suggestion for an alternative!')
  end

  step 'I should see a suggested alternative name prefilled' do
    expect(page).to have_css('input[value="log-lady"]')
  end

  step 'I click to save and exit' do
    click_button 'Save and exit'
  end

  step 'my profile should be partially completed' do
    user = User.find_by(email: 'loglady@example.com')
    expect(user.personal_name).to eq('Margaret')
    expect(user.full_name).to eq('Log Lady')
    expect(user.formal_name).to eq('Mrs Lanterman')
    expect(user.envelope_name).to eq('Mrs M. Lanterman')
    expect(user.phonetic).to be nil
    expect(user.pronoun_sets).to be_empty
  end

  step 'I visit the dashboard' do
    visit '/'
  end

  step 'I click the edit button in the pronouns box' do
    within '.card.is-pronouns' do
      click_on 'Edit'
    end
  end

  step 'I should be on the pronouns page of the profile editor' do
    expect(page).to have_css('h1', text: 'Your pronouns')
  end
  
  step 'I click to add an image' do
    click_button 'Set image'
  end

  step 'I attach my likeness' do
    find('.alternate-input input[type="file"]').set(file_fixture 'leeds.png')
  end

  step 'I accept the defaults in the image editor' do
    expect(page).to have_css('.cropper-crop-box')
    # There's a race condition here - try switching to the rotate tab to make sure we set the dimensions before hitting upload
    find('label', text: 'Rotate').click
    expect(page).to have_css('img.cropper-hidden', visible: false)
    click_button 'Upload'
  end

  step 'my likeness should be cropped and converted' do
    user = User.find_by(email: 'loglady@example.com')
    expect(user.likeness).to be_attached
    blob = user.likeness.attachment.blob
    expect(blob.content_type).to eq('image/jpeg')
    expect(blob.metadata['width']).to eq(blob.metadata['height'])
  end
end

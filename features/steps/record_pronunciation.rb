class Spinach::Features::RecordPronunciation < Spinach::FeatureSteps
  include CommonSteps::Auth

  step 'my user has no audio recorded already' do
    # no op
  end

  step 'I am using a browser with the ability to record audio' do
    expect(::Capybara.current_driver).to eq(:cuprite)
  end

  step 'I have given permission to record audio' do
    page.driver.browser.command("Browser.grantPermissions", origin: page.server_url, permissions: %w[audioCapture])
  end

  step 'I have not given permission to record audio' do
    pending 'step not implemented'
  end

  step 'I should see the permission button' do
    pending 'step not implemented'
  end

  step 'I have revoked permission to record audio' do
    pending 'step not implemented'
  end

  step 'I should see an error message' do
    pending 'step not implemented'
  end

  step 'I visit the profile editing page for pronunciation' do
    visit profile_path(:pronunciation)
  end

  step 'I should see the recorder' do
    expect(page).to have_css('button', text: /Hold to record/)
  end

  step 'the play button and delete button should be disabled' do
    expect(page).to have_css('button[disabled]', text: 'Listen')
    expect(page).to have_css('button[disabled]', text: 'Delete audio')
  end

  step 'my user has audio recorded already' do
    test_user.update(pronunciation: fixture_file_upload(file_fixture('pronunciation.wav'), 'audio/wav'))
  end

  step 'the play button and delete button should be available' do
    expect(page).to have_css('button:not([disabled])', text: 'Listen')
    expect(page).to have_css('button:not([disabled])', text: 'Delete audio')
  end

  step 'I am not using a browser without the ability to record audio' do
    expect(::Capybara.current_driver).to eq(:rack_test)
  end

  step 'I should not see the recorder' do
    expect(page).not_to have_css('.recorder.recorder--active')
  end

  step 'I should see a message telling me to use a different browser' do
    expect(page).to have_content('It looks like recording audio is not currently available in your browser.')
  end
  
  def example_user
    @example_user ||= create :user, :basic_profile
  end

  step 'a user exists with recorded audio' do
    example_user.update(pronunciation: fixture_file_upload(file_fixture('pronunciation.wav'), 'audio/wav'))
  end

  step 'I visit that user\'s public URL' do
    visit user_path(example_user)
  end

  step 'I should see a player, and it should be attached to a valid audio element' do
    expect(page).to have_css('button', text: 'Listen')
    expect(page).to have_css('audio[src]', visible: false)
  end

  step 'a user exists without recorded audio' do
    example_user
  end

  step 'I should not see a player' do
    expect(page).not_to have_css('button', text: 'Listen')
    expect(page).not_to have_css('audio[src]', visible: false)
  end
  
  def fixture_to_data_url(filename, content_type='application/octet-stream')
    "data:#{content_type};base64,#{Base64.strict_encode64(File.read(file_fixture filename))}"
  end
  
  step 'I make a short recording' do
    find('#user_pronunciation_data', visible: false).set(fixture_to_data_url 'pronunciation.wav')
  end

  step 'I click to go to the next step' do
    click_button 'Next step'
  end

  step 'my recording should be saved in storage' do
    test_user.reload
    expect(test_user.pronunciation).to be_attached
    expect(test_user.pronunciation.content_type).to eq('audio/wav')
  end

  step 'I make a recording that is too large' do
    find('#user_pronunciation_data', visible: false).set(fixture_to_data_url '2mb.wav')
  end

  step 'I should see an error requiring me to make a shorter recording' do
    expect(page).to have_css('.help.is-danger', text: 'That file is too large (2.05 MB);')
  end
  
  step 'my recording should not be saved in storage' do
    test_user.reload
    expect(test_user.pronunciation).not_to be_attached
  end
end

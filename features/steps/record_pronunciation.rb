class Spinach::Features::RecordPronunciation < Spinach::FeatureSteps
  include CommonSteps::Auth

  step 'my user has no audio recorded already' do
    # no op
  end

  step 'I am using a browser with the ability to record audio' do
    expect(::Capybara.current_driver).to eq(:cuprite)
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
    test_user.update(pronunciation: fixture_file_upload(fixture 'pronunciation.wav'))
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
    example_user.update(pronunciation: fixture_file_upload(fixture 'pronunciation.wav'))
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
end

class Spinach::Features::ApiKeys < Spinach::FeatureSteps
  include CommonSteps::Auth

  step 'I have 3 API keys created' do
    create :client, name: 'one', user: test_user, created_at: 3.days.ago
    create :client, name: 'two', user: test_user, created_at: 2.days.ago
    create :client, name: 'three', user: test_user, created_at: 1.day.ago
  end

  step 'I visit the account page' do
    visit edit_user_registration_path
  end

  step 'I should see my 3 API keys and their ages' do
    expect(page).to have_css('tr.api-client', count: 3)
    expect(page).to have_content("two 2 days ago")
  end

  step 'I click to delete the first key & confirm the action' do
    within(first('tr.api-client')) do
      accept_confirm do
        click_button 'Delete'
      end
    end
  end

  step 'I should be back on the account page' do
    expect(page).to have_css('.title', text: 'My account')
  end

  step 'I should see a message saying my API key has been deleted' do
    expect(page).to have_content('That API key has been successfully deleted.')
  end

  step 'I should see my remaining 2 API keys' do
    expect(page).to have_css('tr.api-client', count: 2)
  end

  step 'I fill in a new key name' do
    fill_in id: 'client_name', with: 'bookhouse'
  end

  step 'I click to create it' do
    click_button 'Create key'
  end

  step 'I should see a dialog with a JWT for me to copy' do
    expect(page).to have_css('.modal')
    expect(page).to have_css('.message-body', text: /^ey/)
  end
end

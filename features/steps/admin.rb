class Spinach::Features::Admin < Spinach::FeatureSteps
  include CommonSteps::Auth

  SECTIONS = ['Users', 'Pronoun Sets', 'Links', 'Alternate Names', 'Clients'].freeze

  step 'I am signed in as an admin with an API key' do
    admin = create :user, :test, :full_profile, role: :admin
    create :client, user: admin
    sign_in_as admin
  end

  step 'I visit the admin' do
    visit '/admin'
  end

  step 'I should be asked to sign in' do
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  step 'I should be on the home page with a message saying I\'m not permitted' do
    expect(page).to have_current_path('/')
    expect(page).to have_content('Sorry - you are not permitted to do that')
  end

  step 'I should see the admin dashboard' do
    expect(page).to have_css('h2', text: 'Dashboard')
  end

  step 'I should be able to view and edit a record in every section' do
    SECTIONS.each do |section|
      within('#main-menu') { click_on section }
      expect(page).to have_css('h2', text: section)
      within(first('tbody tr')) { find('a', text: /\A\d+\z/).click }
      edit = "Edit #{section.singularize}"
      click_on edit if page.has_link?(edit)
      expect(page).to have_css('h2')
    end
  end
end

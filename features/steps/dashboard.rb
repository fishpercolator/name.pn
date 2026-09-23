class Spinach::Features::Dashboard < Spinach::FeatureSteps
  include CommonSteps::Auth

  step 'I visit the dashboard' do
    visit root_path
  end

  step 'I should see cards displaying every aspect of my name' do
    expect(page).to have_css('article', text: 'Personal name Audrey Full name Audrey Horne')
    expect(page).to have_css('article', text: "Envelope name Ms A. H. Horne Formal name Ms Horne Email name Audrey Name variants that you like\nHester Prynne Scarlett\nName variants that you don\'t like\nAud")
    expect(page).to have_css('article', text: 'Audrey Horne is pronounced AWD-ree HORN')
    expect(page).to have_css('article', text: 'Pronouns: she/her Audrey is a great cook. She is really good at cooking.')
    expect(page).to have_css('article', text: 'What you look like')
    expect(page).to have_css('#likeness img')
    expect(page).to have_css('article', text: 'Your personal links')
    expect(page).to have_css('article', text: 'LinkedIn Twitter')
  end
  
  step 'I should see edit buttons for each section' do
    expect(page).to have_css('article header a[title="Edit"]', count: 7)
    expect(page).to have_css('a', exact_text: 'Edit', count: 1)
  end

  step 'I should see no warnings about sharing my URL' do
    expect(page).not_to have_content('You must set this before you can share your page')
  end

  step 'I should see my URL' do
    expect(page).to have_content('http://www.example.com/audrey-horne')
  end
  
  step 'I should see a pronoun version of my URL' do
    expect(page).to have_content("or, if you prefer a URL containing your pronouns:\nhttp://www.example.com/audrey-horne/she/her")
  end

  step 'I should see enabled buttons to view and copy my URL' do
    expect(page).to have_link('View')
    expect(page).to have_button('Copy', disabled: false)
  end

  step 'I should see cards with indications that things are not set' do
    expect(page).to have_css('article', text: 'Envelope name Not set Formal name Not set')
  end

  step 'I should see warnings about sharing my URL' do
    expect(page).not_to have_content('You must set this before you can share your page', count: 2)
  end

  step 'I should see disabled buttons to view and copy my URL' do
    expect(page).to have_button('View', disabled: true)
    expect(page).to have_button('Copy', disabled: true)
  end

  step 'I have set my name and slug but not my pronouns' do
    test_user.update(full_name: 'Audrey Horne', personal_name: 'Audrey')
  end
end

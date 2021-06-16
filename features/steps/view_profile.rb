class Spinach::Features::ViewProfile < Spinach::FeatureSteps
  include CommonSteps::Auth

  step 'a user exists with a basic profile' do
    create :user, :basic_profile, slug: 'audrey-horne'
  end

  step 'I visit the path that is that user\'s slug' do
    visit "/audrey-horne"
  end
  
  step 'I visit the path that is a mixed-case version of that user\'s slug' do
    visit "/AudreY-hORne"
  end

  step 'I should not see the navbar' do
    expect(page).not_to have_css('.navbar')
  end

  step 'I should see a \'hello\' card with the user\'s personal name and pronouns' do
    expect(page).to have_css('.napc', text: "Hello\nmy name is\nAudrey\nmy pronouns are\nshe/her")
  end

  step 'I should see a box with the full name' do
    expect(page).to have_css('.profile-card', text: "My full name\nAudrey Horne\n")
  end

  step 'I should not see the formal name' do
    expect(page).not_to have_content('Formal name')
  end

  step 'I should not see a pronunciation guide' do
    expect(page).not_to have_content('is pronounced')
  end

  step 'I should see a link to the main site' do
    expect(page).to have_css('a', text: 'Get your own name.pn')
  end

  step 'a user exists with a detailed profile' do
    create :user, :full_profile
  end

  step 'I should see a pronunciation guide' do
    expect(page).to have_content("'Audrey Horne' is pronounced\nAWD-ree HORN")
    expect(page).to have_css('span.is-ipa', text: '/ˈɔːdri hɔːn/')
  end

  step 'I should see the formal name' do
    expect(page).to have_content("Formal name\nMs Horne\n")
    expect(page).to have_content("On an envelope\nMs A. H. Horne\n")
  end

  step 'the user has multiple pronoun sets' do
    User.last.pronoun_sets << create(:pronoun_set, :they)
  end
  
  step 'I should see all the pronoun sets on one line each' do
    expect(page).to have_css('.napc', text: "she/her\nthey/them")
  end
  
  step 'I should see a usage guide for one set of pronouns' do
    expect(page).to have_css('.profile-card__pronoun', count: 1)
    expect(page).to have_content("Audrey is a great cook.\nShe is really good at cooking.\nCooking comes really naturally to her.\n")
  end

  step 'I should see usage guides for all sets of pronouns' do
    expect(page).to have_css('.profile-card__pronoun', count: 2)
    expect(page).to have_content("Audrey is a great cook.\nShe is really good at cooking.\nCooking comes really naturally to her.\n")
    expect(page).to have_content("Audrey is a great cook.\nThey are really good at cooking.\nCooking comes really naturally to them.\n")
  end

  step 'a user exists who has not completed their profile' do
    create :user, full_name: 'Killer BOB', slug: 'audrey-horne'
  end

  step 'I should be redirected to the homepage with a forbidden error' do
    expect(page).to have_css('.navbar')
    expect(page).to have_content('Sorry - you are not permitted to do that')
  end
  
  step 'the user has picked the \'running\' pronoun example' do
    User.friendly.find('audrey-horne').update(pronoun_example: 'running')
  end

  step 'I should see an appropriate usage guide for one set of pronouns' do
    expect(page).to have_css('.profile-card__pronoun', count: 1)
    expect(page).to have_content("Audrey likes to run.\nShe is running a half-marathon.\nI saw her running just yesterday.\nToday she is trying to beat her personal best.\n")
  end
  
  step 'I should not see a section for the user\'s likeness' do
    expect(page).not_to have_content('What I look like')
  end

  step 'I should see the audio player' do
    expect(page).to have_css('button', text: 'Listen')
  end

  step 'I should see the user\'s likeness' do
    expect(page).to have_content('What I look like')
    expect(page).to have_css('a img[src$="likeness.png"]')
  end
  
  step 'I visit the path that is that user\'s slug with "she/her" on the end' do
    visit "/audrey-horne/she/her"
  end

  step 'I should see only "she/her" in their name card' do
    expect(page).to have_css('.napc', text: 'she/her')
    expect(page).not_to have_css('.napc', text: 'they/them')
  end
  
  step 'I should not see a box with links' do
    expect(page).not_to have_content('More about me')
  end

  step 'I should see a box with links in alphabetical order' do
    links = find('.profile-card', text: 'More about me')
    expect(links).to have_content("LinkedIn Twitter")
    expect(links).to have_css('a[href="https://twitter.com/ahorne"]', text: 'Twitter')
  end
end

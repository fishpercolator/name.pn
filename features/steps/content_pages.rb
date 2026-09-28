class Spinach::Features::ContentPages < Spinach::FeatureSteps
  include CommonSteps::Auth

  step "I visit the home page" do
    visit root_path
  end

  step 'I click on "About" in the navbar' do
    within(".site-navbar") { click_on "About" }
  end

  step 'I click on "Terms of use" in the footer' do
    within("footer") { click_on "Terms of use" }
  end

  step 'I click on "Privacy policy" in the footer' do
    within("footer") { click_on "Privacy policy" }
  end

  step "I visit the profile editing page for pronunciation" do
    visit profile_path(:pronunciation)
  end

  step "I click the link to the phonetic spelling guide" do
    click_on "read our guide to writing great phonetic spellings."
  end

  step 'I should see a page titled "About name.pn"' do
    expect(page).to have_css("h1", text: "About name.pn")
  end

  step 'I should see a page titled "Terms and conditions of use"' do
    expect(page).to have_css("h1", text: "Terms and conditions of use")
  end

  step 'I should see a page titled "Privacy policy"' do
    expect(page).to have_css("h1", text: "Privacy policy")
  end

  step 'I should see a page titled "How to write a phonetic spelling"' do
    expect(page).to have_css("h1", text: "How to write a phonetic spelling")
  end
end

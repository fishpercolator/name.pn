class Spinach::Features::ErrorPages < Spinach::FeatureSteps
  include CommonSteps::Auth

  step "I visit a page that doesn't exist" do
    visit "/definitely-not-a-user"
  end

  step "the home page is broken" do
    allow_any_instance_of(HomeController).to receive(:index).and_raise("Kaboom")
  end

  step "I visit the home page" do
    visit root_path
  end

  step "I should see an error page saying the page wasn't found" do
    expect(page).to have_css(".site-navbar")
    expect(page).to have_css(".page-title", text: "Page not found")
  end

  step "I should see an error page saying something went wrong" do
    expect(page).to have_css(".site-navbar")
    expect(page).to have_css(".page-title", text: "Something went wrong")
  end
end

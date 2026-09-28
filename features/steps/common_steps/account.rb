module CommonSteps
  module Account
    include Spinach::DSL

    # The mailing list loads into a lazy frame that pushes the rest of the page down,
    # so wait for it before clicking anything below it
    step "I visit the account page" do
      visit edit_user_registration_path
      expect(page).to have_css("turbo-frame[complete]") if Capybara.current_driver == Capybara.javascript_driver
    end
  end
end

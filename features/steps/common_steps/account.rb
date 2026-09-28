module CommonSteps
  module Account
    include Spinach::DSL

    step "I visit the account page" do
      visit edit_user_registration_path
    end
  end
end

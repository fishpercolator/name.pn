module CommonSteps
  module Auth
    include Spinach::DSL

    step 'I am signed out' do
      # noop
    end

    step 'I am signed in' do
      sign_in_as test_user
    end

    def sign_in_as(user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'letmein123'
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully')
    end

    def test_user
      User.find_by(email: 'testuser@example.com') || create(:user, :test)
    end
  end
end

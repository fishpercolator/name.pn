class Spinach::Features::MailingList < Spinach::FeatureSteps
  include CommonSteps::Auth
  include CommonSteps::Account

  step "I am not subscribed to the mailing list" do
    use_buttondown MockButtondown.new
  end

  step "I am subscribed to the mailing list" do
    use_buttondown MockButtondown.new(test_user.email => {})
  end

  step "I click to subscribe to the mailing list" do
    click_on "Subscribe to mailing list"
    expect(page).not_to have_button("Subscribe to mailing list")
  end

  step "I click to unsubscribe from the mailing list" do
    click_on "Unsubscribe"
    expect(page).not_to have_button("Unsubscribe")
  end

  step "I should be subscribed to the mailing list" do
    expect(@buttondown.subscribed?(test_user.email)).to be true
  end

  step "I should not be subscribed to the mailing list" do
    expect(@buttondown.subscribed?(test_user.email)).to be false
  end

  step "I should see that I am subscribed" do
    expect(page).to have_content("Subscribed: You are currently subscribed to our mailing list")
  end

  step "I should see that I am not subscribed" do
    expect(page).to have_content("Not subscribed: You are currently not subscribed to our mailing list")
  end

  private

  def use_buttondown(buttondown)
    @buttondown = buttondown
    allow(MailingListable).to receive(:buttondown).and_return(buttondown)
  end
end

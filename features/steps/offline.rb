class Spinach::Features::Offline < Spinach::FeatureSteps
  include CommonSteps::Auth

  step 'I have visited the site before' do
    visit root_path
    page.evaluate_async_script('navigator.serviceWorker.ready.then(() => arguments[0]())')
  end

  step 'I lose my internet connection' do
    [browser, *service_workers].each { it.network.emulate_network_conditions(offline: true) }
  end

  step 'I click on "About" in the navbar' do
    within('.site-navbar') { click_on 'About' }
  end

  step 'I should see the offline page' do
    expect(page).to have_css('h1', text: "You're offline")
  end

  private

  def browser = page.driver.browser

  def service_workers
    browser.service_workers.map do |target|
      browser.attach_target(target.id)
      target.worker
    end
  end
end

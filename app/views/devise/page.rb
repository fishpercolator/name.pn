class Views::Devise::Page < Views::Base
  register_value_helper :resource
  register_value_helper :resource_name

  LINKS = {
    log_in: %w[devise.sessions.new.title new_user_session_path],
    sign_up: %w[devise.registrations.new.title new_user_registration_path],
    lost_password: %w[devise.passwords.new.title new_user_password_path]
  }.freeze

  private

  def page(links:, &)
    NarrowContainer do
      PageTitle(t('.title'), class: 'mb-6')
      yield
      ul(class: 'mt-5 space-y-1') do
        links.each { |name| li { auth_link(name) } }
      end
    end
  end

  def form_card(**options, &)
    Card do |card|
      card.body do
        Form(model: resource, scope: resource_name, **options, &)
      end
    end
  end

  def auth_link(name)
    key, path = LINKS.fetch(name)
    Link(public_send(path)) { t(key) }
  end
end

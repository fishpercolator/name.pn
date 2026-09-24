class Views::Devise::Form < Views::Base
  register_value_helper :resource
  register_value_helper :resource_name

  LINKS = {
    log_in: %w[devise.sessions.new.title new_user_session_path],
    sign_up: %w[devise.registrations.new.title new_user_registration_path],
    lost_password: %w[devise.passwords.new.title new_user_password_path]
  }.freeze

  def view_template
    section(class: 'mx-auto w-full max-w-xl px-4 py-12') do
      PageTitle(t('.title'), class: 'mb-6')
      Form(model: resource, scope: resource_name, url: form_url, method: form_method) { |form| body(form) }
      links
    end
  end

  protected

  def form_method = :post

  def body(form)
    Card do
      div(class: 'card-body') do
        fields(form)
        form.submit(t('.submit'), class: 'mt-4')
      end
    end
  end

  private

  def links
    ul(class: 'mt-5 space-y-1') do
      auth_links.each { |name| li { auth_link(*LINKS.fetch(name)) } }
    end
  end

  def auth_link(key, path) = Link(public_send(path)) { t(key) }
end

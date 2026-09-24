class Views::Devise::Registrations::New < Views::Devise::Form
  protected

  def form_url = user_registration_path

  def auth_links = %i[log_in]

  def body(form)
    div(class: 'space-y-5') do
      card { credentials(form) }
      card { form.checkbox :subscribe_to_mailing_list, checked: true }
      card(class: '[&_a]:link') { p { t('.privacy_notice_html', url: page_path('privacy')) } }
      form.checkbox :terms, label: t('.terms_label_html', url: page_path('terms'))
      form.submit(t('.submit'))
    end
  end

  private

  def credentials(form)
    form.field :email, label: t('.email'), hint: t('.email_hint'), autofocus: true
    form.field :password, label: t('.password')
    form.field :password_confirmation
  end

  def card(**attributes, &)
    Card { div(**mix({ class: 'card-body' }, attributes), &) }
  end
end

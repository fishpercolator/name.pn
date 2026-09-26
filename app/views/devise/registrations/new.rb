class Views::Devise::Registrations::New < Views::Devise::Page
  def view_template
    page(links: %i[log_in]) do
      Form(model: resource, scope: resource_name, url: user_registration_path, class: 'space-y-5') do |form|
        Card do |card|
          card.body do
            form.field :email, label: t('.email'), hint: t('.email_hint'), autofocus: true
            form.field :password, label: t('.password')
            form.field :password_confirmation
          end
        end
        Card do |card|
          card.body do
            form.checkbox :subscribe_to_mailing_list, checked: true
          end
        end
        Card do |card|
          card.body(class: '[&_a]:link') do
            p { t('.privacy_notice_html', url: page_path('privacy')) }
          end
        end
        form.checkbox :terms, label: t('.terms_label_html', url: page_path('terms'))
        form.submit t('.submit')
      end
    end
  end
end

class Views::Devise::Registrations::New < Views::Devise::Page
  register_output_helper :cloudflare_turnstile
  register_output_helper :cloudflare_turnstile_script_tag

  def view_template
    load_without_turbo
    page(links: %i[log_in]) do
      Form(model: resource, scope: resource_name, url: user_registration_path, class: "space-y-5", data: { turbo: false }) do |form|
        Card do |card|
          card.body do
            form.field :email, label: t(".email"), hint: t(".email_hint"), autofocus: true
            form.field :password, label: t(".password")
            form.field :password_confirmation
            form.honeypot :website
          end
        end
        Card do |card|
          card.body do
            form.checkbox :subscribe_to_mailing_list, checked: true
          end
        end
        Card do |card|
          card.body(class: "[&_a]:link") do
            p { t(".privacy_notice_html", url: page_path("privacy")) }
          end
        end
        form.checkbox :terms, label: t(".terms_label_html", url: page_path("terms"))
        cloudflare_turnstile_script_tag
        cloudflare_turnstile(action: "sign_up", class: "cf-turnstile min-h-[65px] leading-0")
        form.submit t(".submit")
      end
    end
  end

  private

  def load_without_turbo = set_meta_tags("turbo-visit-control": "reload")
end

class Views::Devise::Registrations::Edit < Views::Devise::Page
  include Phlex::Rails::Helpers::ContentFor
  include Phlex::Rails::Helpers::TurboFrameTag

  controller_variable :clients, :new_client, :new_key

  def view_template
    NarrowContainer(class: 'space-y-12') do
      section { account }
      section { turbo_frame_tag([current_user, 'mailing_list'], src: users_mailing_list_path) }
      section { api_keys }
      section { cancel_link }
    end
    content_for(:modal) { render Components::Account::NewKeyModal.new(@new_key) } if @new_key.present?
  end

  private

  def account
    PageTitle(t('.title'), class: 'mb-6')
    form_card(url: user_registration_path, method: :put) do |form|
      form.field :email, autofocus: true
      form.field :password, label: t('.new_password'), hint: t('.password_hint'), autocomplete: 'off'
      form.field :password_confirmation
      form.field :current_password, hint: t('.current_password_hint')
      form.submit t('.save'), class: 'mt-4'
    end
  end

  def api_keys
    SectionHeading { t('.api_keys') }
    p(class: 'mt-2 mb-4 text-xl') do
      plain t('.api_keys_blurb')
      whitespace
      Link(rswag_ui_path, data: { turbo: false }) { t('.api') }
    end
    render Components::Account::ApiKeys.new(@clients, @new_client)
  end

  def cancel_link
    Link(user_registration_path, data: { turbo_confirm: t('.cancel_confirm'), turbo_method: :delete }) { t('.cancel') }
  end
end

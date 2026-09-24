class Views::Devise::Registrations::Edit < Views::Base
  include Phlex::Rails::Helpers::ContentFor
  include Phlex::Rails::Helpers::TurboFrameTag

  register_value_helper :resource
  register_value_helper :resource_name

  controller_variable :clients, :new_client, :new_key

  def view_template
    div(class: 'mx-auto w-full max-w-xl space-y-12 px-4 py-12') do
      section { account }
      section { turbo_frame_tag([current_user, 'mailing_list'], src: users_mailing_list_path) }
      section { api_keys }
      section { cancel_link }
    end
    new_key_modal if @new_key.present?
  end

  private

  def account
    PageTitle(t('.title'), class: 'mb-6')
    Card do
      div(class: 'card-body') do
        Form(model: resource, scope: resource_name, url: user_registration_path, method: :put) { |form| account_fields(form) }
      end
    end
  end

  def account_fields(form)
    form.error_notification
    form.field :email, autofocus: true
    form.field :password, label: t('.new_password'), hint: t('.password_hint'), autocomplete: 'off'
    form.field :password_confirmation
    form.field :current_password, hint: t('.current_password_hint')
    form.submit(t('.save'), class: 'mt-4')
  end

  def api_keys
    SectionHeading { t('.api_keys') }
    p(class: 'mt-2 mb-4 text-xl') do
      plain t('.api_keys_blurb')
      whitespace
      Link(rswag_ui_path, data: { turbo: false }) { t('.api') }
    end
    render Components::Clients::Table.new(@clients, @new_client)
  end

  def cancel_link
    Link(user_registration_path, data: { turbo_confirm: t('.cancel_confirm'), turbo_method: :delete }) { t('.cancel') }
  end

  def new_key_modal
    content_for(:modal) { render Components::Clients::KeyModal.new(@new_key) }
  end
end

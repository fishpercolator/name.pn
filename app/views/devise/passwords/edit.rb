class Views::Devise::Passwords::Edit < Views::Devise::Page
  def view_template
    page(links: %i[log_in sign_up]) do
      form_card(url: user_password_path, method: :put) do |form|
        form.hidden :reset_password_token
        form.field :password, label: t('.new_password')
        form.field :password_confirmation, label: t('.confirm_new_password')
        form.submit t('.submit'), class: 'mt-4'
      end
    end
  end
end

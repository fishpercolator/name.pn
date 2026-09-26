class Views::Devise::Passwords::New < Views::Devise::Page
  def view_template
    page(links: %i[log_in sign_up]) do
      form_card(url: user_password_path) do |form|
        form.field :email
        form.submit t('.submit'), class: 'mt-4'
      end
    end
  end
end

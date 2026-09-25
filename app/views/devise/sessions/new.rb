class Views::Devise::Sessions::New < Views::Devise::Page
  def view_template
    page(links: %i[sign_up lost_password]) do
      form_card(url: user_session_path) do |form|
        form.field :email
        form.field :password
        form.checkbox :remember_me
        form.submit t('.submit'), class: 'mt-4'
      end
    end
  end
end

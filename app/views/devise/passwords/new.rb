class Views::Devise::Passwords::New < Views::Devise::Form
  protected

  def form_url = user_password_path

  def fields(form)
    form.field :email
  end

  def auth_links = %i[log_in sign_up]
end

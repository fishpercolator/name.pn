class Views::Devise::Passwords::Edit < Views::Devise::Form
  protected

  def form_url = user_password_path

  def form_method = :put

  def fields(form)
    form.hidden :reset_password_token
    form.field :password, label: t('.new_password')
    form.field :password_confirmation, label: t('.confirm_new_password')
  end

  def auth_links = %i[log_in sign_up]
end

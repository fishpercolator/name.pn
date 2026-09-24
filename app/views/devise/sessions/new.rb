class Views::Devise::Sessions::New < Views::Devise::Form
  protected

  def form_url = user_session_path

  def fields(form)
    form.field :email
    form.field :password
    form.checkbox :remember_me
  end

  def auth_links = %i[sign_up lost_password]
end

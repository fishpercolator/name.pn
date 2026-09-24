class Components::Users::LikenessCard < Components::Users::Card
  def render? = @user.likeness.attached?

  protected

  def section = 'likeness'

  def content = Likeness(@user.likeness, name: @user.full_name)
end

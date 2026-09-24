class Components::PublicProfile::LikenessSection < Components::PublicProfile::Section
  def render? = @user.likeness.attached?

  protected

  def section_name = 'likeness'

  def content = Likeness(@user.likeness, name: @user.full_name)
end

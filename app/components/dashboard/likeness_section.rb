class Components::Dashboard::LikenessSection < Components::Dashboard::Section
  protected

  def section_name = :likeness

  def content
    @user.likeness.attached? ? Likeness(@user.likeness, name: @user.full_name) : MissingValue()
  end
end

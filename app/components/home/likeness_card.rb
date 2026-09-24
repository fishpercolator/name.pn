class Components::Home::LikenessCard < Components::Home::Card
  protected

  def section = :likeness

  def content
    @user.likeness.attached? ? Likeness(@user.likeness, name: @user.full_name) : MissingValue()
  end
end

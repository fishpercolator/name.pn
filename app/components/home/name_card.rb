class Components::Home::NameCard < Components::Home::Card
  protected

  def section = :personal_name

  def content
    DetailList(@user) do |list|
      list.attribute :personal_name, required: true
      list.attribute :full_name, required: true
    end
  end
end

class Components::Home::NameCard < Components::Home::Card
  private

  def section = :personal_name

  def content
    DetailList do |list|
      attribute(list, :personal_name, required: true)
      attribute(list, :full_name, required: true)
    end
  end
end

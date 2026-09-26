class Components::Dashboard::NameSection < Components::Dashboard::Section
  protected

  def section_name = :personal_name

  def content
    DetailList(@user) do |list|
      list.attribute :personal_name, required: true
      list.attribute :full_name, required: true
    end
  end
end

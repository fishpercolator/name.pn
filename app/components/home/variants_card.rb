class Components::Home::VariantsCard < Components::Home::Card
  private

  def section = :variants

  def content
    DetailList do |list|
      %i[envelope_name formal_name email_name].each { attribute(list, it) }
      alternate_names(list)
    end
  end

  def alternate_names(list)
    @user.alternate_names.grouped_by_category.each do |category, names|
      list.item(t(category, scope: 'alternate_name_categories')) { BulletList(names.map(&:name)) }
    end
  end
end

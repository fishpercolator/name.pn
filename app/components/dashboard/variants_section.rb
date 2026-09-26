class Components::Dashboard::VariantsSection < Components::Dashboard::Section
  protected

  def section_name = :variants

  def content
    DetailList(@user) do |list|
      %i[envelope_name formal_name email_name].each { list.attribute(it) }
      alternate_names(list)
    end
  end

  private

  def alternate_names(list)
    @user.alternate_names.grouped_by_category.each do |category, names|
      list.item(t(category, scope: 'alternate_name_categories')) do
        BulletList do |bullets|
          names.each { |name| bullets.item { name.name } }
        end
      end
    end
  end
end

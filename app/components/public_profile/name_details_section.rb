class Components::PublicProfile::NameDetailsSection < Components::PublicProfile::Section
  NAMES = %i[full_name personal_name envelope_name formal_name email_name].freeze

  protected

  def section_name = 'name-details'

  def content
    names.each { |name, value| detail(t(".headings.#{name}"), hint: t(".hints.#{name}", value:)) { value } }
    @user.alternate_names.grouped_by_category.each { |category, names| variants(category, names) }
  end

  private

  def names = NAMES.index_with { @user.public_send(it) }.compact_blank

  def variants(category, names)
    detail(t(".headings.variants.#{category}_html"), hint: t(".hints.variants.#{category}")) do
      BulletList(markers: :inside) do |bullets|
        names.each { |name| bullets.item { name.name } }
      end
    end
  end
end

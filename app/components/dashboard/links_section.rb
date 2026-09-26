class Components::Dashboard::LinksSection < Components::Dashboard::Section
  protected

  def section_name = :links

  def content
    links.any? ? link_list : MissingValue()
  end

  private

  def links = @user.links.order(:title)

  def link_list
    BulletList do |bullets|
      links.each { |link| bullets.item { Link(link.url, rel: 'noopener') { link.title } } }
    end
  end
end

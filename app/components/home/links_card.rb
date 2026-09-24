class Components::Home::LinksCard < Components::Home::Card
  protected

  def section = :links

  def content
    links.any? ? link_list : MissingValue()
  end

  private

  def links = @user.links.order(:title)

  def link_list
    BulletList { |bullets| links.each { |link| bullets.item { Link(link.url, rel: 'noopener') { link.title } } } }
  end
end

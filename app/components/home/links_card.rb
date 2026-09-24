class Components::Home::LinksCard < Components::Home::Card
  private

  def section = :links

  def content
    links.any? ? BulletList(links) { |link| Link(link.url, rel: 'noopener') { link.title } } : MissingValue()
  end

  def links = @user.links.order(:title)
end

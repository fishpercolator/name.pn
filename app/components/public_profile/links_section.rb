class Components::PublicProfile::LinksSection < Components::PublicProfile::Section
  def render? = links.any?

  protected

  def section_name = 'links'

  def content
    Hint(class: 'profile-card__hint') { t('.hint', name: @user.personal_name) }
    BulletList(markers: :inside) { |bullets| links.each { |link| bullets.item { Link(link.url, rel: 'me nofollow') { link.title } } } }
  end

  private

  def links = @user.links.order(:title)
end

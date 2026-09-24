class Components::Users::LinksCard < Components::Users::Card
  def render? = links.any?

  protected

  def section = 'links'

  def content
    Hint(class: 'profile-card__hint') { t('.hint', name: @user.personal_name) }
    BulletList { |bullets| links.each { |link| bullets.item { Link(link.url, rel: 'me nofollow') { link.title } } } }
  end

  private

  def links = @user.links.order(:title)
end

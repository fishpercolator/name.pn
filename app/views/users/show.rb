class Views::Users::Show < Views::Base
  controller_variable :user, :pronoun_sets

  def view_template
    Container(data: { controller: 'public-profile', action: 'hashchange@window->public-profile#hashChange' }) do
      div(class: 'mx-auto md:w-1/2') do
        render Components::Users::NameBadge.new(@user, @pronoun_sets)
        cards
      end
    end
    div(class: 'p-4 text-center') { a(href: root_path, class: 'link text-base-200') { t('.blurb') } }
  end

  private

  def cards
    render Components::Users::PronunciationCard.new(@user)
    render Components::Users::NameDetailsCard.new(@user)
    render Components::Users::LikenessCard.new(@user)
    render Components::Users::PronounsCard.new(@user, @pronoun_sets)
    render Components::Users::LinksCard.new(@user)
  end
end

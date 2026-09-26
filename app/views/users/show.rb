class Views::Users::Show < Views::Base
  controller_variable :user, :pronoun_sets

  def view_template
    Container(data: { controller: 'public-profile', action: 'hashchange@window->public-profile#hashChange' }) do
      div(class: 'mx-auto md:w-1/2') do
        render Components::PublicProfile::NameAndPronounCard.new(@user, @pronoun_sets)
        cards
      end
    end
    div(class: 'p-4 text-center') { a(href: root_path, class: 'link text-base-200') { t('.blurb') } }
  end

  private

  def cards
    render Components::PublicProfile::PronunciationSection.new(@user)
    render Components::PublicProfile::NameDetailsSection.new(@user)
    render Components::PublicProfile::LikenessSection.new(@user)
    render Components::PublicProfile::PronounsSection.new(@user, @pronoun_sets)
    render Components::PublicProfile::LinksSection.new(@user)
  end
end

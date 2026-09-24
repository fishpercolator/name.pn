class Views::Home::UserHome < Views::Base
  def initialize(user)
    @user = user
  end

  def view_template
    div(class: 'container mx-auto px-4 py-12') do
      PageTitle { page_title(t('.title')) }
      Blurb(t('.page_description1'), t('.page_description2'), class: 'mt-6 text-xl')
      cards
    end
  end

  private

  def cards
    div(class: 'mt-12 grid grid-cols-1 gap-6 md:grid-cols-2') do
      card Components::Home::UrlCard
      column Components::Home::NameCard, Components::Home::PronounsCard, Components::Home::PronunciationCard
      column Components::Home::VariantsCard, Components::Home::LikenessCard, Components::Home::LinksCard
    end
  end

  def column(*cards)
    div(class: 'flex flex-col gap-6 [&>*]:grow') { cards.each { card(it) } }
  end

  def card(type) = render type.new(@user)
end

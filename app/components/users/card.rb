class Components::Users::Card < Components::Base
  SEE_ALL = 'profile-card__see-all hidden group-[.is-shown-alone]:block'.freeze

  def initialize(user)
    @user = user
  end

  def view_template
    ProfileCard(t('.title'), id: section, class: 'profile-card group mt-6', footer: { class: SEE_ALL }, data: { public_profile_target: 'card' }) do |card|
      card.tool("##{section}", icon: 'link', label: t('components.users.card.link_to_this_section'), class: 'text-accent-content')
      card.content { div { content } }
      card.action(href: '#') { t('components.users.card.see_all') }
    end
  end

  private

  def heading(text, **attributes)
    h3(**mix({ class: 'text-accent' }, attributes)) { text }
  end

  def detail(label, hint:, &)
    heading(label, class: 'mt-8 first:mt-0')
    div(class: 'font-bold', &)
    Hint(class: 'profile-card__hint') { hint }
  end
end

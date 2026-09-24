module UsersHelper

  def section_link(section)
    link_to("##{section}", class: 'btn btn-square btn-ghost btn-sm text-accent-content', title: t('users.show.link_to_this_section')) do
      icon('link', class: 'size-6 fill-current')
    end
  end

  def see_all
    content_tag(:footer, class: 'profile-card__see-all hidden border-t border-base-300 p-4 text-center text-xl group-[.is-shown-alone]:block') do
      link_to(t('users.show.see_all'), '#', class: 'link link-secondary')
    end
  end

end

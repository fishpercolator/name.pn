module UsersHelper

  def section_link(section)
    link_to("##{section}", class: 'card-header-icon', title: t('users.show.link_to_this_section')) do
      content_tag(:span, class: 'icon') do
        content_tag(:i, nil, class: 'mdi mdi-link')
      end
    end
  end

  def see_all
    content_tag(:footer, class: 'card-footer profile-card__see-all') do
      link_to(t('users.show.see_all'), '#', class: 'card-footer-item')
    end
  end

end

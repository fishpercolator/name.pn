module ApplicationHelper

  # The default meta tags for every page
  def default_meta_tags
    {
      site: t('product_name'), 
      reverse: true, 
      viewport: 'width=device-width, initial-scale=1.0', 
      'theme-color' => '#2e333d',
      'view-transition': 'same-origin',
      'turbo-refresh-method': 'morph',
    }
  end

  # A section for a content page
  # If title or id are provided, they will be used appropriately.
  # page_title indicates this is the first section and should be an h1 and the title of the page
  def page_section(title: nil, id: nil, page_title: false)
    content_tag(:section, class: block_given? ? 'section' : 'section pb-0', id: id) do
      content_tag(:div, class: 'container') do
        content_tag(:div, class: 'columns') do
          content_tag(:div, class: 'column is-three-fifths is-offset-one-fifth') do
            if title.present?
              if page_title
                concat(content_tag :h1, title(title), class: 'title is-2')
              else
                concat(content_tag :h2, title, class: 'title')
              end
            end
            concat(content_tag(:div, class: page_title ? 'content mt-5 is-size-5' : 'content is-size-5') { yield if block_given? })
          end
        end
      end
    end
  end
end

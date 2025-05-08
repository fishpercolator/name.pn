# frozen_string_literal: true

class Components::PageHeader < Components::Base
  # From https://www.hyperui.dev/components/marketing/headers

  def view_template
    header(class: 'bg-secondary text-secondary-foreground') do
      div(class: 'mx-auto flex h-16 max-w-screen-xl items-center gap-8 px-4 sm:px-6 lg:px-8') do
        render_logo
        div(class: 'flex flex-1 items-center justify-end md:justify-between') do
          render_links
        end
      end
    end
  end

  protected

  def render_logo
    a(class: 'flex justify-start items-center gap-2', href: root_path) do
      inline_svg_tag('logo.svg', class: 'h-8', size: "100%")
      span(class: 'text-lg font-bold') { t('product_name') }
    end
  end

  def render_links
    links = [
      {text: 'About', href: page_path('about')}
    ]
    nav(aria_label: 'Global', class: 'hidden md:block') do
      ul(class: 'flex items-center gap-6 text-sm') do
        links.each do |l|
          Link(class: 'text-current', href: l[:href]) { l[:text] }
        end
      end
    end
  end

end

# frozen_string_literal: true

class Components::PageHeader < Components::Base
  # From https://github.com/ruby-ui/web/blob/main/app/components/shared/navbar.rb
  
  def initialize
    @main_links = []
    @action_links = []
  end

  def view_template(&)
    vanish(&)
    header(class: 'supports-backdrop-blur:bg-background/80 sticky top-0 z-50 w-full border-b bg-background/80 backdrop-blur-2xl backdrop-saturate-200') do
      div(class: 'px-2 sm:px-4 sm:container flex h-14 items-center justify-between') do
        div(class: 'mr-4 flex items-center') do
          render_logo
          @main_links.each { render_link(it) }
        end
        div(class: 'flex items-center gap-x-2 divide-x md:divide-none') do
          div(class: 'flex items-center') do
            @action_links.each { render_link(it) }
            render_theme_toggle
          end
          render_dropdown_menu
        end
      end
    end
  end

  def main_link(href, **args, &content)
    @main_links << {href:, content:, **args}
  end

  def action_link(href, **args, &content)
    @action_links << {href:, content:, **args}
  end

  protected

  def render_logo
    a(class: 'mr-6 flex items-center space-x-2', href: root_path) do
      inline_svg_tag('logo.svg', class: 'h-8', size: "100%")
      span(class: 'text-lg font-bold') { t('product_name') }
    end
  end
  
  def render_link(link)
    Link(**mix(link.except(:content), {variant: :ghost, class: 'hidden md:inline-block'}), &link[:content])
  end

  def render_dropdown_menu
    DropdownMenu(class: 'md:hidden', options: {placement: 'bottom-end'}) do
      DropdownMenuTrigger(class: 'flex items-center') do
        Button(variant: :ghost, icon: true) { icon('menu', class: 'fill-current') }
      end
      DropdownMenuContent do
        (@main_links + @action_links).each { render_dropdown_link(it) }
      end
    end
  end

  def render_dropdown_link(link)
    DropdownMenuItem(**link.except(:content), &link[:content])
  end

  def render_theme_toggle
    ThemeToggle do |toggle|
      SetLightMode(class: 'flex items-center') do
        Button(variant: :ghost, icon: true) { icon('white-balance-sunny', class: 'fill-current p-2') }
      end
      SetDarkMode(class: 'dark:flex items-center') do
        Button(variant: :ghost, icon: true) { icon('weather-night', class: 'fill-current p-2') }
      end
    end
  end
end

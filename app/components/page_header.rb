# frozen_string_literal: true

class Components::PageHeader < Components::Base
  # From https://www.hyperui.dev/components/marketing/headers

  def view_template
    header(class: 'bg-secondary text-secondary-foreground') do
      div(class: container_classes + %w[flex h-16 items-center gap-8]) do
        render_logo
        div(class: 'flex flex-1 items-center justify-end md:justify-between') do
          render_links
          render_actions
        end
      end
    end
  end

  protected

  def links
    [
      {text: t('.about'), href: page_path('about')},
    ]
  end

  def render_logo
    a(class: 'flex justify-start items-center gap-2', href: root_path) do
      inline_svg_tag('logo.svg', class: 'h-8', size: "100%")
      span(class: 'text-lg font-bold') { t('product_name') }
    end
  end

  def render_links
    nav(aria_label: 'Global', class: 'hidden md:block') do
      ul(class: 'flex items-center gap-6 text-sm') do
        links.each do |l|
          Link(class: 'text-current', href: l[:href]) { l[:text] }
        end
      end
    end
  end

  def render_actions
    div(class: 'flex items-center gap-4') do
      # Links that are visible on mobile and desktop
      div(class: 'sm:flex items-center sm:gap-4') do
        Link(variant: :primary, href: new_user_session_path) { "Login" }
      end
      # Links that are hidden behind the burger on mobile
      div(class: 'hidden sm:flex') do
        Link(variant: :primary, href: new_user_registration_path) { "Sign up" }
        render_theme_toggle
      end
      # The burger itself
      div(class: 'block md:hidden') do
        Button { icon('menu', class: 'fill-current') }
      end
    end
  end

  def render_theme_toggle
    ThemeToggle do |toggle|
      SetLightMode(class: 'flex items-center') do
        Button(variant: :ghost, icon: true) do
          icon('white-balance-sunny', class: 'fill-current p-2')
        end
      end
      SetDarkMode(class: 'dark:flex items-center') do
        Button(variant: :ghost, icon: true) do
          icon('weather-night', class: 'fill-current p-2')
        end
      end
    end
  end
end

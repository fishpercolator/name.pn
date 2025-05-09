# frozen_string_literal: true

class Components::PageHeader < Components::Base
  # From https://github.com/ruby-ui/web/blob/main/app/components/shared/navbar.rb
  register_value_helper :user_signed_in?
  register_output_helper :current_user

  def view_template
    header(class: 'supports-backdrop-blur:bg-background/80 sticky top-0 z-50 w-full border-b bg-background/80 backdrop-blur-2xl backdrop-saturate-200') do
      div(class: 'px-2 sm:px-4 sm:container flex h-14 items-center justify-between') do
        div(class: 'mr-4 flex items-center') do
          render_logo
          nav_link(page_path('about')) { t('.about') }
        end
        div(class: 'flex items-center gap-x-2 md:divide-x') do
          div(class: 'flex items-center') do
            render_user_links
            render_theme_toggle
          end
        end
      end
    end
  end

  protected

  def nav_link(href, **args, &)
    Link(**mix(args, {href: href, variant: :ghost, class: 'hidden md:inline-block'}), &)
  end

  def render_logo
    a(class: 'mr-6 flex items-center space-x-2', href: root_path) do
      inline_svg_tag('logo.svg', class: 'h-8', size: "100%")
      span(class: 'text-lg font-bold') { t('product_name') }
    end
  end

  def render_user_links
    if user_signed_in?
      nav_link(admin_root_path) { t('.admin') } if current_user.role_admin?
      nav_link(edit_user_registration_path) { t('devise.registrations.edit.title') }
      nav_link(destroy_user_session_path, data: {turbo_method: :delete}) { t('devise.sessions.destroy.title') }
    else
      nav_link(new_user_session_path) { t('devise.sessions.new.title') }
      nav_link(new_user_registration_path) { t('devise.registrations.new.title') }
    end
  end

  def render_theme_toggle
    ThemeToggle(class: 'hidden md:block') do |toggle|
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

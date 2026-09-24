class Components::UI::SiteNavbar < Components::Base
  include Phlex::Rails::Helpers::ImageTag

  def view_template
    Navbar(class: 'site-navbar bg-neutral text-neutral-content', aria: { label: t('.label') }) do |navbar|
      navbar.brand { logo }
      navbar.leading { Menu { |menu| menu.item(page_path('about')) { t('.about') } } }
      navbar.trailing { Menu { |menu| account_links(menu) } }
    end
  end

  private

  def logo
    a(href: root_path, class: 'flex flex-1 items-center gap-1 px-2 text-2xl md:flex-none') do
      image_tag('logo.svg', alt: t('icon_alt'), class: 'h-[1em]')
      b { t('product_name') }
    end
  end

  def account_links(menu) = user_signed_in? ? member_links(menu) : visitor_links(menu)

  def member_links(menu)
    menu.item(admin_root_path) { t('.admin') } if current_user.role_admin?
    menu.item(edit_user_registration_path) { t('devise.registrations.edit.title') }
    menu.item(destroy_user_session_path, data: { turbo_method: :delete }) { t('devise.sessions.destroy.title') }
  end

  def visitor_links(menu)
    menu.item(new_user_session_path) { t('devise.sessions.new.title') }
    menu.item(new_user_registration_path) { t('devise.registrations.new.title') }
  end
end

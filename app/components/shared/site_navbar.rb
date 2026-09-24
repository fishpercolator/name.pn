class Components::Shared::SiteNavbar < Components::Base
  def view_template
    Navbar(class: 'site-navbar bg-neutral text-neutral-content', aria: { label: t('.label') }) do |navbar|
      navbar.brand { Brand(href: root_path) }
      navbar.leading { site_links }
      navbar.trailing { account_links }
    end
  end

  private

  def site_links
    Menu { |menu| menu.item(page_path('about')) { t('.about') } }
  end

  def account_links = user_signed_in? ? member_links : visitor_links

  def member_links
    Menu do |menu|
      menu.item(admin_root_path) { t('.admin') } if current_user.role_admin?
      menu.item(edit_user_registration_path) { t('devise.registrations.edit.title') }
      menu.item(destroy_user_session_path, data: { turbo_method: :delete }) { t('devise.sessions.destroy.title') }
    end
  end

  def visitor_links
    Menu do |menu|
      menu.item(new_user_session_path) { t('devise.sessions.new.title') }
      menu.item(new_user_registration_path) { t('devise.registrations.new.title') }
    end
  end
end

class Components::Shared::SiteFooter < Components::Base
  GITHUB = 'https://github.com/fishpercolator/name.pn'.freeze
  ROADMAP = 'https://github.com/orgs/fishpercolator/projects/1'.freeze

  def view_template
    Footer(aria: { label: t('.label') }) do
      legal_links
      project_links
    end
  end

  private

  def legal_links
    Menu do |menu|
      menu.item(page_path('terms'), icon: 'file-sign') { t('.terms') }
      menu.item(page_path('privacy'), icon: 'shield-account') { t('.privacy') }
    end
  end

  def project_links
    Menu do |menu|
      menu.item(GITHUB, icon: 'github') { t('.github') }
      menu.item(ROADMAP, icon: 'map') { t('.roadmap') }
      menu.item(rswag_ui_path, icon: 'cogs', data: { turbo: false }) { t('.api') }
    end
  end
end

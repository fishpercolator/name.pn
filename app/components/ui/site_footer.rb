class Components::UI::SiteFooter < Components::Base
  GITHUB = 'https://github.com/fishpercolator/name.pn'.freeze
  ROADMAP = 'https://github.com/orgs/fishpercolator/projects/1'.freeze

  def view_template
    nav(class: 'bg-base-100', aria: { label: t('.label') }) do
      div(class: 'container mx-auto md:flex md:justify-between') do
        Menu { |menu| legal_links(menu) }
        Menu { |menu| project_links(menu) }
      end
    end
  end

  private

  def legal_links(menu)
    menu.item(page_path('terms'), icon: 'file-sign') { t('.terms') }
    menu.item(page_path('privacy'), icon: 'shield-account') { t('.privacy') }
  end

  def project_links(menu)
    menu.item(GITHUB, icon: 'github') { t('.github') }
    menu.item(ROADMAP, icon: 'map') { t('.roadmap') }
    menu.item(rswag_ui_path, icon: 'cogs', data: { turbo: false }) { t('.api') }
  end
end

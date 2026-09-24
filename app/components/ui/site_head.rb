class Components::UI::SiteHead < Components::Base
  include Phlex::Rails::Helpers::CSRFMetaTags
  include Phlex::Rails::Helpers::CSPMetaTag
  include Phlex::Rails::Helpers::FaviconLinkTag
  include Phlex::Rails::Helpers::JavaScriptIncludeTag
  include Phlex::Rails::Helpers::StyleSheetLinkTag

  register_output_helper :display_meta_tags

  def view_template
    display_meta_tags(meta_tags)
    csrf_meta_tags
    csp_meta_tag
    icons
    assets
    Analytics()
  end

  private

  def meta_tags
    {
      site: t('product_name'),
      reverse: true,
      viewport: 'width=device-width, initial-scale=1.0',
      'theme-color' => '#071f21',
      'view-transition': 'same-origin'
    }
  end

  def icons
    favicon_link_tag
    favicon_link_tag('apple-touch-icon.png', rel: 'apple-touch-icon', type: 'image/png')
    link(rel: 'manifest', href: manifest_path(format: :json))
  end

  def assets
    javascript_include_tag('application', type: 'module', defer: true, data: { turbo_track: 'reload' })
    link(rel: 'preconnect', href: 'https://fonts.googleapis.com', crossorigin: true)
    stylesheet_link_tag('application', media: 'all')
  end
end

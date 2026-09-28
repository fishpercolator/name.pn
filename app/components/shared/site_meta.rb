class Components::Shared::SiteMeta < Components::Base
  register_output_helper :display_meta_tags

  def view_template
    display_meta_tags(
      site: t('product_name'),
      reverse: true,
      viewport: 'width=device-width, initial-scale=1.0',
      'theme-color' => Rails.configuration.x.pwa.theme_color,
      'view-transition': 'same-origin'
    )
  end
end

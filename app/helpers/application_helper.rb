module ApplicationHelper

  # The default meta tags for every page
  def default_meta_tags
    {
      site: t('product_name'), 
      reverse: true, 
      viewport: 'width=device-width, initial-scale=1.0', 
      'theme-color' => '#2e333d',
      'view-transition': 'same-origin',
      # FIXME: This is commented out until the UI is rewritten with Turbo in mind
      # For example, the modal that appears after creating an API key doesn't
      # work with morphing on
      #'turbo-refresh-method': 'morph',
    }
  end

end

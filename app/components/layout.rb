# frozen_string_literal: true

class Components::Layout < Components::Base
  include Phlex::Rails::Layout
  prop :title, String

  def view_template
    doctype
    html(lang: 'en') do
      render_head
      head do
        title { @title }
      end

      body do
        yield
      end
    end
  end

  protected

  def render_head
    head do
      helpers.display_meta_tags default_meta_tags
      csrf_meta_tags
      csp_meta_tag
      favicon_link_tag
      favicon_link_tag 'apple-touch-icon.png', rel: 'apple-touch-icon', type: 'image/png'
      link(rel: 'manifest', href: manifest_path(format: :json))
      javascript_include_tag 'application', data_turbo_track: 'reload', type: 'module'
      stylesheet_link_tag 'tailwind', media: 'all', data_turbo_track: 'reload'
      render partial('layouts/ga')
    end
  end

  def default_meta_tags
    {
      site: t('product_name'), 
      reverse: true, 
      viewport: 'width=device-width, initial-scale=1.0', 
      'theme-color' => '#2e333d',
      'view-transition': 'same-origin',
      'turbo-refresh-method': 'morph',
    }
  end
end

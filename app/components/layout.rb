# frozen_string_literal: true

class Components::Layout < Components::Base
  include Phlex::Rails::Layout

  register_output_helper :display_meta_tags
  
  def view_template
    doctype
    html(lang: 'en', class: html_class) do
      render_head
      body(class: 'bg-background text-foreground') do
        yield
      end
    end
  end

  protected

  def html_class
    nil
  end

  def render_head
    head do
      display_meta_tags default_meta_tags
      csrf_meta_tags
      csp_meta_tag
      favicon_link_tag
      favicon_link_tag 'apple-touch-icon.png', rel: 'apple-touch-icon', type: 'image/png'
      link(rel: 'manifest', href: manifest_path(format: :json))
      javascript_include_tag 'application', data_turbo_track: 'reload', type: 'module'
      google_fonts
      stylesheet_link_tag 'tailwind', media: 'all', data_turbo_track: 'reload'
      render partial('layouts/ga')
    end
  end

  def google_fonts
    link(rel: 'preconnect', href: 'https://fonts.googleapis.com')
    link(rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: true)
    link(href: 'https://fonts.googleapis.com/css2?family=Raleway:ital,wght@0,100..900;1,100..900&display=swap', rel: 'stylesheet')
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

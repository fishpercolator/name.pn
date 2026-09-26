class Components::UI::Brand < Components::Base
  include Phlex::Rails::Helpers::ImageTag

  def initialize(href:)
    @href = href
  end

  def view_template
    a(href: @href, class: 'flex flex-1 items-center gap-1 px-2 text-2xl md:flex-none') do
      image_tag('logo.svg', alt: t('icon_alt'), class: 'h-[1em]')
      b { t('product_name') }
    end
  end
end

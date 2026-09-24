class Components::UI::Likeness < Components::Base
  include Phlex::Rails::Helpers::ImageTag
  include Phlex::Rails::Helpers::URLFor

  def initialize(image, name:)
    @image = image
    @name = name
  end

  def view_template
    a(href: url_for(@image), class: 'mx-auto block w-fit cursor-zoom-in', title: t('.expand'), data: { controller: 'lightbox' }) do
      image_tag(@image.variant(resize_to_limit: [300, 300]), alt: t('.alt', name: @name), class: 'rounded-full')
    end
  end
end

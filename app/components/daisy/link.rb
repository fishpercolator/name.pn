class Components::Daisy::Link < Components::Base
  def initialize(href, **attributes)
    @href = href
    @attributes = attributes
  end

  def view_template(&)
    a(href: @href, **mix({ class: 'link link-secondary' }, @attributes), &)
  end
end

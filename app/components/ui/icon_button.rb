class Components::UI::IconButton < Components::Base
  def initialize(href, icon:, label:, **attributes)
    @href = href
    @icon = icon
    @label = label
    @attributes = attributes
  end

  def view_template
    Button(href: @href, variant: :ghost, shape: :square, size: :sm, title: @label, aria: { label: @label }, **@attributes) do
      Icon(@icon, class: 'size-5 fill-current')
    end
  end
end

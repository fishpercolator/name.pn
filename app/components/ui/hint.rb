class Components::UI::Hint < Components::Base
  SIZES = { sm: 'text-sm', base: 'text-base' }.freeze

  def initialize(size: :base, **attributes)
    @size = size
    @attributes = attributes
  end

  def view_template(&)
    div(**mix({ class: ['text-muted [&_a]:link', SIZES.fetch(@size)] }, @attributes), &)
  end
end

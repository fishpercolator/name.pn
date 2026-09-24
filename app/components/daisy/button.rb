class Components::Daisy::Button < Components::Base
  include Phlex::Rails::Helpers::ButtonTo

  VARIANTS = {
    neutral: nil,
    primary: 'btn-primary',
    secondary: 'btn-secondary',
    success: 'btn-success',
    danger: 'btn-error',
    ghost: 'btn-ghost'
  }.freeze
  SIZES = { xs: 'btn-xs', sm: 'btn-sm', md: nil, lg: 'btn-lg', xl: 'btn-xl' }.freeze
  SHAPES = { nil => nil, square: 'btn-square', circle: 'btn-circle' }.freeze

  def initialize(href: nil, method: nil, variant: :neutral, outline: false, size: :md, shape: nil, icon: nil, **attributes)
    @href = href
    @method = method
    @variant = variant
    @outline = outline
    @size = size
    @shape = shape
    @icon = icon
    @attributes = attributes
  end

  def view_template(&)
    if @method
      button_to(@href, method: @method, **attributes) { label(&) }
    elsif @href
      a(href: @href, **attributes) { label(&) }
    else
      button(type: :button, **attributes) { label(&) }
    end
  end

  private

  def label(&)
    Icon(@icon) if @icon
    render(&)
  end

  def attributes = mix({ class: classes }, @attributes)

  def classes
    ['btn', VARIANTS.fetch(@variant), ('btn-outline' if @outline), SIZES.fetch(@size), SHAPES.fetch(@shape)]
  end
end

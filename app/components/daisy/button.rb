class Components::Daisy::Button < Components::Base
  include Phlex::Rails::Helpers::ButtonTo

  MODIFIERS = {
    primary: 'btn-primary', secondary: 'btn-secondary', success: 'btn-success', danger: 'btn-danger', ghost: 'btn-ghost',
    outline: 'btn-outline',
    xs: 'btn-xs', sm: 'btn-sm', lg: 'btn-lg', xl: 'btn-xl',
    square: 'btn-square', circle: 'btn-circle'
  }.freeze

  def initialize(href: nil, method: nil, variant: nil, outline: false, size: nil, shape: nil, icon: nil, **attributes)
    @href = href
    @method = method
    @modifiers = [variant, (:outline if outline), size, shape].compact
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

  def classes = ['btn', *@modifiers.map { MODIFIERS.fetch(it) }]
end

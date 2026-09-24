class Components::Daisy::Button < Components::Base
  include Phlex::Rails::Helpers::ButtonTo

  def initialize(href: nil, method: nil, variant: nil, outline: false, size: nil, shape: nil, icon: nil, **attributes)
    @href = href
    @method = method
    @modifiers = [variant, ('outline' if outline), size, shape]
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

  def classes = ['btn', *@modifiers.compact.map { "btn-#{it}" }]
end

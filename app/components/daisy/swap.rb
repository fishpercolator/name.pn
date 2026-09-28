class Components::Daisy::Swap < Components::Base
  EFFECTS = { rotate: 'swap-rotate', flip: 'swap-flip' }.freeze

  def initialize(effect: nil, **attributes)
    @effect = effect
    @attributes = attributes
  end

  def view_template(&)
    vanish(&)
    span(**mix({ class: ['swap', EFFECTS[@effect]] }, @attributes)) do
      span(class: 'swap-off flex items-center gap-1.5', &@off)
      span(class: 'swap-on flex items-center gap-1.5', &@on)
    end
  end

  def on(&block) = @on = block
  def off(&block) = @off = block
end

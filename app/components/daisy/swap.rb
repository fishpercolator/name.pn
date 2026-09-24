class Components::Daisy::Swap < Components::Base
  def view_template(&)
    vanish(&)
    span(class: 'swap') do
      span(class: 'swap-off flex items-center gap-1.5', &@off)
      span(class: 'swap-on flex items-center gap-1.5', &@on)
    end
  end

  def on(&block) = @on = block
  def off(&block) = @off = block
end

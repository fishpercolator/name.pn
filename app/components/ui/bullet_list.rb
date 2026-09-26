class Components::UI::BulletList < Components::Base
  MARKERS = { outside: 'list-outside', inside: 'list-inside' }.freeze

  def initialize(markers: :outside, **attributes)
    @markers = markers
    @attributes = attributes
  end

  def view_template(&)
    ul(**mix({ class: ['list-[square]', MARKERS.fetch(@markers)] }, @attributes), &)
  end

  def item(&) = li(&)
end

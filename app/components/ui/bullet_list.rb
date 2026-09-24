class Components::UI::BulletList < Components::Base
  MARKERS = { outside: 'list-outside', inside: 'list-inside' }.freeze

  def initialize(markers: :outside)
    @markers = markers
  end

  def view_template(&)
    ul(class: ['list-[square]', MARKERS.fetch(@markers)], &)
  end

  def item(&) = li(&)
end

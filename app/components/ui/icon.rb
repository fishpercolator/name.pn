class Components::UI::Icon < Components::Base
  register_output_helper :inline_svg_tag

  def initialize(name, class: 'size-[1em] fill-current')
    @name = name
    @class = grab(class:)
  end

  def view_template
    inline_svg_tag("icons/#{@name}.svg", class: @class)
  end
end

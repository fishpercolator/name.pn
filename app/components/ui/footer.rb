class Components::UI::Footer < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    nav(**mix({ class: 'bg-base-100' }, @attributes)) do
      div(class: 'container mx-auto md:flex md:justify-between', &)
    end
  end
end

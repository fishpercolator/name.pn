class Components::Daisy::Menu < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    ul(**mix({ class: 'menu text-base md:menu-horizontal' }, @attributes), &)
  end

  def item(href, icon: nil, **attributes, &)
    li do
      a(href:, **attributes) do
        Icon(icon) if icon
        render(&)
      end
    end
  end
end

class Components::Daisy::Navbar < Components::Base
  TOGGLE = 'navbar-toggle'.freeze

  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    vanish(&)
    nav(**mix({ class: 'navbar flex-wrap' }, @attributes)) do
      div(class: 'container mx-auto flex flex-wrap items-center') do
        render @brand
        toggle
        collapsible
      end
    end
  end

  def brand(&block) = @brand = block
  def leading(&block) = @leading = block
  def trailing(&block) = @trailing = block

  private

  def toggle
    label(for: TOGGLE, class: 'btn btn-square btn-ghost text-current md:hidden', aria: { label: t('.menu') }) do
      Icon('menu', class: 'size-6 fill-current')
    end
    input(id: TOGGLE, type: :checkbox, class: 'peer hidden')
  end

  def collapsible
    div(class: 'hidden w-full flex-col peer-checked:flex md:flex md:w-auto md:grow md:flex-row md:justify-between') do
      render @leading
      render @trailing
    end
  end
end

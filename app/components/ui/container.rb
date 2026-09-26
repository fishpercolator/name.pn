class Components::UI::Container < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    tag(element, **mix({ class: ['mx-auto px-4 py-12', width] }, @attributes), &)
  end

  protected

  def element = :div

  def width = 'container'
end

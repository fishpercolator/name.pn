class Components::Daisy::Card < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    article(**mix({ class: 'card overflow-hidden bg-base-100 shadow-md' }, @attributes), &)
  end

  def body(**attributes, &)
    div(**mix({ class: 'card-body' }, attributes), &)
  end
end

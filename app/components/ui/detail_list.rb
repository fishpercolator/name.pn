class Components::UI::DetailList < Components::Base
  def initialize(model = nil)
    @model = model
  end

  def view_template(&)
    dl(class: 'leading-7', &)
  end

  def item(label, &)
    dt(class: 'mt-5 font-bold first:mt-0') { label }
    dd(class: 'mt-1 ms-6', &)
  end

  def attribute(name, label: @model.class.human_attribute_name(name), required: false)
    item(label) { value(name, required:) }
  end

  private

  def value(name, required:)
    @model.public_send(:"#{name}?") ? plain(@model.public_send(name)) : MissingValue(required:)
  end
end

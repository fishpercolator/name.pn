class Components::Daisy::Table < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    div(class: 'overflow-x-auto rounded-box border border-base-300 bg-base-100') do
      table(**mix({ class: 'table table-zebra text-base [&_th]:text-base [&_th]:text-base-content' }, @attributes), &)
    end
  end
end

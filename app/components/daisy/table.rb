class Components::Daisy::Table < Components::Base
  def initialize(**attributes)
    @attributes = attributes
    @headings = []
    @rows = []
  end

  def view_template(&)
    vanish(&)
    div(class: 'overflow-x-auto rounded-box border border-base-300 bg-base-100') do
      table(**mix({ class: 'table table-zebra text-base [&_th]:text-base [&_th]:text-base-content' }, @attributes)) do
        thead { tr { @headings.each { |heading| th { heading } } } } if @headings.any?
        tbody { @rows.each { |attributes, cells| tr(**attributes, &cells) } } if @rows.any?
      end
    end
  end

  def headings(*labels) = @headings = labels

  def row(**attributes, &cells)
    @rows << [attributes, cells]
  end

  def cell(&) = td(&)
end

class Components::Daisy::Table < Components::Base
  def initialize(headings: [], **attributes)
    @headings = headings
    @attributes = attributes
    @rows = []
  end

  def view_template(&)
    vanish(&)
    div(class: 'overflow-x-auto rounded-box border border-base-300 bg-base-100') do
      table(**mix({ class: 'table table-zebra text-base [&_th]:text-base [&_th]:text-base-content' }, @attributes)) do
        heading_row if @headings.any?
        data_rows if @rows.any?
      end
    end
  end

  def row(**attributes, &cells)
    @rows << [attributes, cells]
  end

  def cell(&) = td(&)

  private

  def heading_row
    thead do
      tr { @headings.each { |heading| th { heading } } }
    end
  end

  def data_rows
    tbody do
      @rows.each { |attributes, cells| tr(**attributes, &cells) }
    end
  end
end

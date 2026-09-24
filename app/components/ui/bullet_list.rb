class Components::UI::BulletList < Components::Base
  def initialize(items)
    @items = items
  end

  def view_template
    ul(class: 'list-disc leading-7') do
      @items.each { |item| li { block_given? ? yield(item) : item } }
    end
  end
end

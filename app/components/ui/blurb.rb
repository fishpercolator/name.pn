class Components::UI::Blurb < Components::Base
  def initialize(*paragraphs, **attributes)
    @paragraphs = paragraphs
    @attributes = attributes
  end

  def view_template
    div(**mix({ class: 'space-y-4 text-muted' }, @attributes)) do
      @paragraphs.each { |paragraph| p { paragraph } }
    end
  end
end

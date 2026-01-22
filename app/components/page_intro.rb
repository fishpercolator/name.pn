# frozen_string_literal: true

class Components::PageIntro < Components::Base
  def initialize(title:, paragraphs: [], class: nil, **attributes)
    @title = title
    @paragraphs = paragraphs
    @attributes = attributes
  end

  def view_template
    section(**mix({ class: "mt-10 mb-15" }, @attributes)) do
      Heading(level: 1, class: 'mb-5') { @title }
      @paragraphs.each do |para|
        Text(as: 'p', size: '5', weight: 'muted', class: 'my-2') { para }
      end
    end
  end
end

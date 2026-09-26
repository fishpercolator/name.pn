class Components::UI::PageTitle < Components::Base
  def initialize(text, **attributes)
    @text = text
    @attributes = attributes
  end

  def view_template
    set_meta_tags(title: @text)
    h1(**mix({ class: 'page-title text-4xl font-bold' }, @attributes)) { @text }
  end
end

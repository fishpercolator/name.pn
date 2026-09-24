class Components::UI::SectionCard < Components::Base
  ACTION = 'section-card__action h-auto flex-1 rounded-none border-0 py-3 font-normal text-secondary not-first:border-s not-first:border-base-300'.freeze

  def initialize(title, footer: {}, **attributes)
    @title = title
    @footer = footer
    @attributes = attributes
    @actions = []
  end

  def view_template(&)
    vanish(&)
    Card(**@attributes) do
      div(class: ['flex grow flex-col', body_class]) do
        title_bar
        div(class: ['card-body grow gap-4 [&_p]:grow-0', content_class], &@content)
      end
      action_bar if @actions.any?
    end
  end

  def tool(href, icon:, label:, **attributes)
    @tool = { href:, icon:, label:, **attributes }
  end

  def content(&block) = @content = block

  def action(**attributes, &label)
    @actions << [attributes, label]
  end

  protected

  def body_class = nil

  def title_bar_class = nil

  def content_class = nil

  private

  def title_bar
    header(class: ['flex items-center justify-between gap-2 px-4 py-3 shadow-sm', title_bar_class]) do
      h2(class: 'text-xl font-bold') { @title }
      tool_button(**@tool) if @tool
    end
  end

  def tool_button(href:, icon:, label:, **attributes)
    Button(href:, variant: :ghost, shape: :square, size: :sm, title: label, aria: { label: }, **attributes) do
      Icon(icon, class: 'size-5 fill-current')
    end
  end

  def action_bar
    footer(**mix({ class: 'border-t border-base-300 bg-base-100' }, @footer)) do
      div(class: 'flex') do
        @actions.each { |attributes, label| Button(variant: :ghost, **mix({ class: ACTION }, attributes), &label) }
      end
    end
  end
end

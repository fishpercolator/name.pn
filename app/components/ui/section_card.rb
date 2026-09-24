class Components::UI::SectionCard < Components::Base
  TONES = {
    url: 'bg-url',
    personal_name: 'bg-personal-name',
    pronouns: 'bg-pronouns',
    pronunciation: 'bg-pronunciation',
    variants: 'bg-variants',
    likeness: 'bg-likeness',
    links: 'bg-links'
  }.freeze
  ACTION = 'section-card__action h-auto flex-1 rounded-none border-0 py-3 font-normal text-secondary not-first:border-s not-first:border-base-300'.freeze

  def initialize(title, tone: nil, **attributes)
    @title = title
    @tone = tone
    @attributes = attributes
    @actions = []
  end

  def view_template(&)
    vanish(&)
    Card(**@attributes) do
      div(class: ['flex grow flex-col', TONES[@tone]]) do
        title_bar
        div(class: 'card-body grow gap-4 [&_p]:grow-0', &@content)
      end
      action_bar if @actions.any?
    end
  end

  def tool(href, icon:, label:, **attributes)
    @tool = -> { Button(href:, variant: :ghost, shape: :square, size: :sm, title: label, aria: { label: }, **attributes) { Icon(icon, class: 'size-5 fill-current') } }
  end

  def content(&block) = @content = block

  def action(**attributes, &block)
    @actions << -> { Button(variant: :ghost, **mix({ class: ACTION }, attributes), &block) }
  end

  private

  def title_bar
    header(class: 'flex items-center justify-between gap-2 px-4 py-2 shadow-sm') do
      h2(class: 'font-bold') { @title }
      @tool&.call
    end
  end

  def action_bar
    footer(class: 'flex border-t border-base-300 bg-base-100') { @actions.each(&:call) }
  end
end

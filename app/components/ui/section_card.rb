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

  def initialize(title, tone: nil, **attributes)
    @title = title
    @tone = tone
    @attributes = attributes
  end

  def view_template(&)
    vanish(&)
    Card(**@attributes) do
      div(class: ['flex grow flex-col', TONES[@tone]]) do
        heading
        div(class: 'card-body grow gap-4 [&_p]:grow-0', &@content)
      end
      action_bar
    end
  end

  def tool(&block) = @tool = block
  def content(&block) = @content = block
  def actions(&block) = @actions = block

  private

  def action_bar
    buttons = capture(&@actions) if @actions
    footer(class: 'flex border-t border-base-300 bg-base-100') { raw safe(buttons) } if buttons.present?
  end

  def heading
    header(class: 'flex items-center justify-between gap-2 px-4 py-2 shadow-sm') do
      h2(class: 'font-bold') { @title }
      render(&@tool) if @tool
    end
  end
end

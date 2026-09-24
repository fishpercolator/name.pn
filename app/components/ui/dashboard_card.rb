class Components::UI::DashboardCard < Components::UI::SectionCard
  TONES = {
    url: 'bg-url',
    personal_name: 'bg-personal-name',
    pronouns: 'bg-pronouns',
    pronunciation: 'bg-pronunciation',
    variants: 'bg-variants',
    likeness: 'bg-likeness',
    links: 'bg-links'
  }.freeze

  def initialize(title, tone:, **attributes)
    super(title, **attributes)
    @tone = tone
  end

  protected

  def body_class = TONES.fetch(@tone)
end

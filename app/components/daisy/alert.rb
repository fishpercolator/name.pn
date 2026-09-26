class Components::Daisy::Alert < Components::Base
  TONES = { info: 'alert-info', warning: 'alert-warning', error: 'alert-error' }.freeze

  def initialize(tone: :info, icon: nil, **attributes)
    @tone = tone
    @icon = icon
    @attributes = attributes
  end

  def view_template(&)
    div(role: 'alert', **mix({ class: ['alert', TONES.fetch(@tone)] }, @attributes)) do
      Icon(@icon, class: 'size-6 fill-current') if @icon
      span(&)
    end
  end
end

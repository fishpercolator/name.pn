class Components::UI::Player < Components::Base
  def initialize(url, variant: :secondary, size: nil, **attributes)
    @url = url
    @variant = variant
    @size = size
    @attributes = attributes
  end

  def view_template
    div(**mix({ class: 'player', data: { controller: 'player', player_url_value: @url } }, @attributes)) do
      audio(data: { player_target: 'media' })
      Button(variant: @variant, size: @size, icon: 'play', disabled: true, data: { player_target: 'play', action: 'player#play' }) { t('.listen') }
    end
  end
end

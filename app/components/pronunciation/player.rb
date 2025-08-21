# frozen_string_literal: true

class Components::Pronunciation::Player < Components::Base
  attr_reader :data, :attributes
  
  def initialize(data:, **attributes)
    @data = data
    @attributes = attributes
  end

  def view_template
    div(data: mix({controller: 'player'}, data)) do
      audio(controls: false, data: {player_target: 'media'})
      Button(**mix({data: { player_target: 'play', action: 'player#play' }, type: :primary, disabled: true}, attributes)) do
        icon 'play', class: 'h-5 w-5 fill-current -ml-1 mr-1'
        span { t('.listen') }
      end
    end
  end
end

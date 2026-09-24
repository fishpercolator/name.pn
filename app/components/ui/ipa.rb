class Components::UI::Ipa < Components::Base
  def initialize(transcription, **attributes)
    @transcription = transcription
    @attributes = attributes
  end

  def view_template
    span(**mix({ class: 'font-ipa' }, @attributes)) { "/#{@transcription}/" }
  end
end

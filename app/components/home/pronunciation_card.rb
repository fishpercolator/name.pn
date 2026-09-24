class Components::Home::PronunciationCard < Components::Home::Card
  include Phlex::Rails::Helpers::URLFor

  private

  def section = :pronunciation

  def content
    DetailList do |list|
      list.item(t('.name_is_pronounced', name:)) { value(:phonetic) }
      list.item(t('.ipa', name:)) { ipa }
      list.item(t('.audio_clip', name:)) { audio }
    end
  end

  def name = @user.pronunciation_of_name

  def ipa = @user.ipa? ? Ipa(@user.ipa) : MissingValue()

  def audio = @user.pronunciation.attached? ? Player(url_for(@user.pronunciation)) : MissingValue()
end

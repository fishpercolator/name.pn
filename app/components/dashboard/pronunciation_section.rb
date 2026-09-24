class Components::Dashboard::PronunciationSection < Components::Dashboard::Section
  include Phlex::Rails::Helpers::URLFor

  protected

  def section_name = :pronunciation

  def content
    DetailList(@user) do |list|
      list.attribute :phonetic, label: t('.name_is_pronounced', name:)
      list.item(t('.ipa', name:)) { ipa }
      list.item(t('.audio_clip', name:)) { audio }
    end
  end

  private

  def name = @user.pronunciation_of_name

  def ipa = @user.ipa? ? Ipa(@user.ipa) : MissingValue()

  def audio = @user.pronunciation.attached? ? Player(url_for(@user.pronunciation)) : MissingValue()
end

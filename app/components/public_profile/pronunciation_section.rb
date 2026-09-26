class Components::PublicProfile::PronunciationSection < Components::PublicProfile::Section
  include Phlex::Rails::Helpers::URLFor

  def render? = @user.phonetic? || @user.ipa? || @user.pronunciation.attached?

  protected

  def section_name = 'pronunciation'

  def content
    detail(t('.heading', name: @user.pronunciation_of_name), hint: t('.hint')) do
      div(class: 'flex flex-wrap items-center gap-4') do
        span { @user.phonetic } if @user.phonetic?
        Ipa(@user.ipa, class: 'profile-card__ipa text-xl font-normal text-muted') if @user.ipa?
        Player(url_for(@user.pronunciation)) if @user.pronunciation.attached?
      end
    end
  end
end

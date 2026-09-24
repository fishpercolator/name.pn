class Components::PublicProfile::PronounsSection < Components::PublicProfile::Section
  def initialize(user, pronoun_sets)
    super(user)
    @pronoun_sets = pronoun_sets
  end

  protected

  def section_name = 'pronouns'

  def content
    Hint(class: 'profile-card__hint text-base') { t('.hint') }
    pronounless_note if @user.pronounless_style?
    @pronoun_sets.each { pronoun_set(it) }
  end

  private

  def pronounless_note
    p(class: 'mt-5 text-xl') { t(".pronounless_blurbs.#{@user.pronounless_style}_html") }
  end

  def pronoun_set(set)
    div(class: 'profile-card__pronoun mt-8') do
      heading(set.to_s(@user))
      PronounSet::EXAMPLES.each { |inflection| p(class: 'mt-3 text-xl') { PronounExample(set, @user, inflection) } }
    end
  end
end

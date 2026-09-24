class Components::Dashboard::PronounsSection < Components::Dashboard::Section
  protected

  def section_name = :pronouns

  def blurb = super.first

  def content
    if @user.pronounless_style?
      p(class: 'font-bold') { t(@user.pronounless_style, scope: 'pronounless_styles') }
    elsif pronoun_sets.any?
      examples_table
    else
      MissingValue(required: true)
    end
  end

  private

  def pronoun_sets = @user.pronoun_sets

  def examples_table
    Table do
      thead { tr { pronoun_sets.each { |set| th { t('.header', pronoun: set.to_s(@user)) } } } }
      tbody { PronounSet::EXAMPLES.each { example_row(it) } }
    end
  end

  def example_row(inflection)
    tr { pronoun_sets.each { |set| td { PronounExample(set, @user, inflection) } } }
  end
end

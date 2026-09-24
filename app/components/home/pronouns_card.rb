class Components::Home::PronounsCard < Components::Home::Card
  private

  def section = :pronouns

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

  def pronoun_sets = @user.pronoun_sets

  def examples_table
    Table do
      thead { tr { pronoun_sets.each { |set| th { t('.header', pronoun: set.to_s(@user)) } } } }
      tbody { example_rows.each { |row| tr { row.each { |example| td { example } } } } }
    end
  end

  def example_rows = pronoun_sets.map { it.examples(@user) }.transpose
end

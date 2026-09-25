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
    Table do |table|
      table.headings(*pronoun_sets.map { t('.header', pronoun: it.to_s(@user)) })
      PronounSet::EXAMPLES.each do |inflection|
        table.row { pronoun_sets.each { |set| table.cell { PronounExample(set, @user, inflection) } } }
      end
    end
  end
end

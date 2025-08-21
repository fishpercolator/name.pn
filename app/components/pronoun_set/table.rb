# frozen_string_literal: true

class Components::PronounSet::Table < Components::Base
  def initialize(pronoun_sets:, user:)
    @pronoun_sets = pronoun_sets
    @user = user
  end

  def view_template
    render RubyUI::Table.new do
      header
      body
    end
  end

  def header
    TableHeader do
      TableRow do
        @pronoun_sets.each do |pronoun_set|
          TableHead { t('.header', pronoun: pronoun_set.to_s(@user)) }
        end
      end
    end
  end

  def body
    TableBody do
      inflexes.each do |inflex|
        TableRow do
          @pronoun_sets.each do |pronoun_set|
            pronoun = (inflex == :name ? @user.personal_name : pronoun_set.public_send(inflex))
            TableCell { raw safe(t(inflex, pronoun: pronoun, pronoun_initial: pronoun.capitalize, nominative: pronoun_set.nominative, nominative_initial: pronoun_set.nominative.capitalize, copula: pronoun_set.copula, personal_name: @user.personal_name, scope: "pronoun_examples.#{@user.pronoun_example}")) }
          end
        end
      end
    end
  end

  def inflexes
    %i[name nominative oblique possessive_determiner possessive reflexive]
  end

end

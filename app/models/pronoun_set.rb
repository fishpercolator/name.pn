class PronounSet < ApplicationRecord
  acts_as_list
  default_scope -> { order(position: :asc) }

  scope :random, -> { reorder(Arel.sql 'RANDOM()') }
  
  EXAMPLES = %i[name nominative oblique possessive_determiner possessive reflexive].freeze

  attr_accessor :name_only

  has_many :user_pronoun_sets
  has_many :users, through: :user_pronoun_sets

  def to_s(user=nil)
    if name_only
      I18n.t('please_use_my_name')
    elsif user&.pronoun_style_three?
      "#{nominative}/#{oblique}/#{possessive}"
    elsif nominative == oblique
      "#{nominative}/#{possessive}"
    else
      "#{nominative}/#{oblique}"
    end
  end

  def examples(user)
    EXAMPLES.map { example(it, user) }
  end

  # Return a special pronoun set for a user who only wants to use their name
  def self.name_only(user)
    new(
      name_only: true,
      nominative: "#{user.personal_name}",
      oblique: "#{user.personal_name}",
      possessive_determiner: "#{user.personal_name}'s",
      possessive: "#{user.personal_name}'s",
      reflexive: "#{user.personal_name}",
      copula: 'is'
    )
  end

  private

  def example(inflection, user)
    pronoun = inflection == :name ? user.personal_name : public_send(inflection)
    I18n.t(inflection, scope: "pronoun_examples.#{user.pronoun_example}", **interpolations(pronoun, user)).html_safe
  end

  def interpolations(pronoun, user)
    {
      pronoun:, pronoun_initial: pronoun.capitalize,
      nominative:, nominative_initial: nominative.capitalize,
      copula:, personal_name: user.personal_name
    }.transform_values { ERB::Util.h(it) }
  end
end

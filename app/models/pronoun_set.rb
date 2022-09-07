class PronounSet < ApplicationRecord
  acts_as_list
  default_scope -> { order(position: :asc) }

  scope :random, -> { reorder(Arel.sql 'RANDOM()') }
  
  attr_accessor :name_only

  has_and_belongs_to_many :users

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

  # Return a special pronoun set for a user who only wants to use their name
  def self.name_only(user)
    new(
      name_only: true,
      nominative: user.personal_name,
      oblique: user.personal_name,
      possessive_determiner: user.personal_name + "'s",
      possessive: user.personal_name + "'s",
      reflexive: user.personal_name,
      copula: 'is'
    )
  end

end

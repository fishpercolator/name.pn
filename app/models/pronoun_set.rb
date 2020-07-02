class PronounSet < ApplicationRecord
  acts_as_list
  default_scope -> { order(position: :asc) }
  
  has_and_belongs_to_many :users

  def to_s
    "#{nominative}/#{oblique}"
  end

end

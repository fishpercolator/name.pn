class PronounSet < ApplicationRecord
  has_and_belongs_to_many :users

  def to_s
    "#{nominative}/#{oblique}"
  end

end

class PronounSet < ApplicationRecord

  def to_s
    "#{nominative}/#{oblique}"
  end

end

class AlternateName < ApplicationRecord
  belongs_to :user
  enum :category, %w[like ok sometimes dislike].index_by(&:to_sym), prefix: true
  
  validates :name, :category, presence: true
  
  scope :grouped_by_category, -> { order(:category, :name).group_by(&:category) }
end

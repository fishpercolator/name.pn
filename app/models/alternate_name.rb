class AlternateName < ApplicationRecord
  belongs_to :user
  enum :category, %w[like ok sometimes dislike].index_by(&:to_sym), prefix: true
  
  validates :name, :category, presence: true
  
  scope :grouped_by_category, -> { order(:category, :name).group_by(&:category) }

  # This needs updating if filters in the admin UI change
  def self.ransackable_attributes(auth_object = nil)
    %w[user_id name created_at updated_at]
  end
  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end
end

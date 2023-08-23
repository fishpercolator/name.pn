class Link < ApplicationRecord
  belongs_to :user
  
  validates :title, :url, presence: true
  validates :url, format: URI::regexp(%w[http https])
  
  # This needs updating if filters in the admin UI change
  def self.ransackable_attributes(auth_object = nil)
    %w[user_id title url created_at updated_at]
  end
  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end
end

class Link < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :url, format: URI::regexp(%w[http https])
  
end

class AlternateName < ApplicationRecord
  belongs_to :user
  enum category: {like: 'like', ok: 'ok', sometimes: 'sometimes', dislike: 'dislike'}, _prefix: true
  
  validates :name, :category, presence: true
end

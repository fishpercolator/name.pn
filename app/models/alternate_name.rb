class AlternateName < ApplicationRecord
  belongs_to :user
  enum category: {like: 'like', sometimes: 'sometimes', ok: 'ok', dislike: 'dislike'}, _prefix: true
  
  validates :name, :category, presence: true
end

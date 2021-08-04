class AlternateName < ApplicationRecord
  belongs_to :user
  enum category: {variant: 'variant', nickname: 'nickname', wrong: 'wrong'}, _prefix: true
  
  validates :name, :category, presence: true
end

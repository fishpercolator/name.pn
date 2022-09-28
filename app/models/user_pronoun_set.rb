class UserPronounSet < ApplicationRecord
  acts_as_list
  default_scope -> { order(position: :asc) }
  
  belongs_to :user
  belongs_to :pronoun_set

end

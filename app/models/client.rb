class Client < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  belongs_to :user
  devise :jwt_authenticatable, jwt_revocation_strategy: self
  
  validates :name, presence: true
  
end

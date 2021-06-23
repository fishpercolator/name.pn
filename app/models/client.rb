class Client < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  belongs_to :user
  devise :jwt_authenticatable, jwt_revocation_strategy: self
  
  validates :name, presence: true
  
  # Get a fresh JWT for the current JTI
  def generate_token
    Warden::JWTAuth::UserEncoder.new.call(self, 'client', nil).first
  end
  
end

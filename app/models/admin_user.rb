class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  # This needs updating if filters in the admin UI change
  def self.ransackable_attributes(auth_object = nil)
    %w[email]
  end
  def self.ransackable_associations(auth_object = nil)
    %w[]
  end
end

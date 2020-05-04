class User < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, use: :slugged
  
  has_and_belongs_to_many :pronoun_sets
  
  enum role: {user: 'user', admin: 'admin'}, _prefix: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
       
  def to_s
    full_name.present? ? full_name : email
  end
  
  # To have a complete profile you must have entered a full name,
  # a personal name and at least one pronoun
  def profile_complete?
    full_name.present? && personal_name.present? && pronoun_sets.any?
  end
  
end

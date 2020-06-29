class User < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  has_and_belongs_to_many :pronoun_sets
  
  enum role: {user: 'user', admin: 'admin'}, _prefix: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
           
  validates :personal_name, :full_name, presence: true, unless: :new_record?
  validates :slug, format: { with: /\A[-\w]+-[-\w]+\Z/, allow_blank: true }
  validate :slug_uniqueness
    
  def to_s
    full_name.present? ? full_name : email
  end
  
  # To have a complete profile you must have entered a full name,
  # a personal name and at least one pronoun
  def profile_complete?
    full_name.present? && personal_name.present? && pronoun_sets.any? && slug.present?
  end
  
  def slug_uniqueness
    if slug_changed? && !slug_generator.available?(slug)
      errors.add(:slug, :unavailable)
      # And generate a suggestion
      self.slug = nil
      set_slug
    end
  end
  
  # Don't unset the slug if it's invalid because we want to keep the suggestion
  def unset_slug_if_invalid
  end
  
  def slug_candidates
    if full_name.present?
      [
        :full_name,
        [:full_name, :spicy_proton]
      ]
    end
  end
  
  private
  
  def spicy_proton
    @@sp ||= Spicy::Proton.new
    @@sp.pair
  end
  
end

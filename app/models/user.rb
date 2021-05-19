class User < ApplicationRecord
  include UserSlug
  include MailingListable
  include ActiveStorageSupport::SupportForBase64
    
  has_and_belongs_to_many :pronoun_sets
  has_many :links
  
  enum role: {user: 'user', admin: 'admin'}, _prefix: true
  
  enum pronoun_example: {
    boardgaming: 'boardgaming',
    cooking: 'cooking', 
    dancing: 'dancing',
    reading: 'reading',
    running: 'running',
    tv: 'tv',
  }, _prefix: true, _default: 'cooking'
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
           
  validates :personal_name, :full_name, presence: true, unless: :new_record?
  
  has_one_base64_attached :pronunciation
  has_one_attached :likeness
  
  accepts_nested_attributes_for :links
  
  def to_s
    full_name.present? ? full_name : email
  end
  
  # To have a complete profile you must have entered a full name,
  # a personal name and at least one pronoun
  def profile_complete?
    full_name.present? && personal_name.present? && pronoun_sets.any? && slug.present?
  end
end

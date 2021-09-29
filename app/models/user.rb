class User < ApplicationRecord
  include UserSlug
  include UserImage
  include MailingListable
  include ActiveStorageSupport::SupportForBase64
    
  has_and_belongs_to_many :pronoun_sets
  has_many :links
  has_many :alternate_names
  has_many :clients
  
  enum role: {user: 'user', admin: 'admin'}, _prefix: true
  
  enum pronoun_example: {
    boardgaming: 'boardgaming',
    cooking: 'cooking', 
    dancing: 'dancing',
    reading: 'reading',
    running: 'running',
    tv: 'tv',
  }, _prefix: true, _default: 'cooking'
  
  enum pronunciation_of: {
    full_name: 'full_name',
    personal_name: 'personal_name',
    formal_name: 'formal_name',
    envelope_name: 'envelope_name'
  }, _prefix: true, _default: 'full_name'
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
           
  validates :personal_name, :full_name, presence: true, unless: :new_record?
  
  has_one_base64_attached :pronunciation
  has_one_attached :likeness
  
  accepts_nested_attributes_for :links, allow_destroy: true
  accepts_nested_attributes_for :alternate_names, allow_destroy: true
  
  def to_s
    full_name.present? ? full_name : email
  end
  
  # Which name is the pronunciation of?
  def pronunciation_of_name
    # This is safe because pronunciation_of is an enum and rejects invalid values
    public_send(pronunciation_of)
  end
  
  # To be able to freely move around the profile, you must have entered a full
  # name and a personal name
  def basic_names_complete?
    full_name.present? && personal_name.present?
  end
  
  # To have a complete profile you must have entered a full name,
  # a personal name and at least one pronoun
  def profile_complete?
    basic_names_complete? && pronoun_sets.any? && slug.present?
  end
end

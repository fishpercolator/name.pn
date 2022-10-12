class User < ApplicationRecord
  include UserSlug
  include UserImage
  include MailingListable
  include ActiveStorageSupport::SupportForBase64
  
  has_many :user_pronoun_sets
  has_many :pronoun_sets, -> { reorder('user_pronoun_sets.position': :asc) }, through: :user_pronoun_sets
  has_many :links, dependent: :destroy
  has_many :alternate_names, dependent: :destroy
  has_many :clients, dependent: :destroy
  
  enum :role, %w[user admin].index_by(&:to_sym), prefix: true
  
  enum :pronoun_example, %w[boardgaming cooking dancing reading running tv].index_by(&:to_sym), prefix: true, default: :cooking
  
  enum :pronunciation_of, %w[full_name personal_name formal_name envelope_name].index_by(&:to_sym), prefix: true, default: :full_name
  
  enum :pronoun_style, %w[two three].index_by(&:to_sym), prefix: true
  enum :pronounless_style, %w[none unknown any].index_by(&:to_sym), prefix: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
           
  validates :personal_name, :full_name, presence: true, unless: :new_record?
  
  has_one_base64_attached :pronunciation
  has_one_attached :likeness
  
  accepts_nested_attributes_for :links, allow_destroy: true
  accepts_nested_attributes_for :alternate_names, allow_destroy: true
  accepts_nested_attributes_for :user_pronoun_sets, allow_destroy: true
  
  validates :likeness, size: { less_than: 1.megabyte }
  validates :pronunciation, size: { less_than: 2.megabytes }

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
  # a personal name and at least one pronoun or declared yourself pronounless
  def profile_complete?
    basic_names_complete? && (pronoun_sets.any? || pronounless_style.present?) && slug.present?
  end

  def pronoun_sets_with_preference
    case pronounless_style&.to_sym
    when :none, :unknown
      [PronounSet.name_only(self)]
    when :any
      PronounSet.random.limit(3)
    else
      pronoun_sets
    end
  end
end

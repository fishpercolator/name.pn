# This module contains all the logic for managing the user slugs with a modified friendly_id
module UserSlug
  extend ActiveSupport::Concern
  
  included do
    extend FriendlyId
    
    friendly_id :slug_candidates, use: :slugged

    # Valid slugs start with a letter, contain at least one - and have letters/numbers on either side of that -
    validates :slug, format: { with: /\A[a-z][a-z\d]*-[a-z\d][-a-z\d]*\Z/i, allow_blank: true }
    validate :slug_uniqueness
    
    def slug_uniqueness
      self.slug&.downcase!
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
    
    def spicy_proton
      @@sp ||= Spicy::Proton.new
      @@sp.pair
    end
    private :spicy_proton
    
  end
end

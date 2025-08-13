# frozen_string_literal: true

class Components::Home::Card::Variants < Components::Base
  def view_template
    render Home::Card.new(title: t('.title'), edit: profile_path(:variants), class: 'bg-variants') do |hc|
      hc.content do
        hc.blurb { t('profile.variants.blurb') }
        attributes = hc.user_attributes_hash %i[envelope_name formal_name email_name]
        hc.list(attributes.merge(human_alternate_names))
      end
    end
  end

  private

  # Convert current_user.alternate_names.grouped_by_category to human-readable form
  def human_alternate_names
    current_user.alternate_names.grouped_by_category.to_h do |cat,v|
      [
        t(cat, scope: 'alternate_name_categories'),
        v.map(&:name)
      ]
    end
  end
end

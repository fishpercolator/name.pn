# frozen_string_literal: true

class Components::Home::Card::Pronouns < Components::Base
  def view_template
    render Home::Card.new(title: t('.title'), edit: profile_path(:pronouns), class: 'bg-pronouns') do |hc|
      hc.content do
        hc.blurb { t('profile.pronouns.blurb')&.first }
        if current_user.pronoun_sets.any?
          render PronounSet::Table.new(pronoun_sets: current_user.pronoun_sets, user: current_user)
        else
          p { hc.you_must }
        end
      end
    end
  end
end

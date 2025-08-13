# frozen_string_literal: true

class Components::Home::Card::Pronunciation < Components::Base
  def view_template
    render Home::Card.new(title: t('.title'), edit: profile_path(:pronunciation), class: 'bg-pronunciation') do |hc|
      hc.content do
        hc.blurb { t('profile.pronunciation.blurb') }
      end
    end
  end
end

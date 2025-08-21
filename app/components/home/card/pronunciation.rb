# frozen_string_literal: true

class Components::Home::Card::Pronunciation < Components::Base
  def view_template
    render Home::Card.new(title: t('.title'), edit: profile_path(:pronunciation), class: 'bg-pronunciation') do |hc|
      hc.content do
        hc.blurb { t('profile.pronunciation.blurb') }
        hc.list({
          t('.name_is_pronounced', name: current_user.pronunciation_of_name) => 
          current_user.phonetic,
          t('.ipa', name: current_user.pronunciation_of_name) =>
          current_user.ipa? ? "/#{current_user.ipa}/": nil,
          t('.audio_clip', name: current_user.pronunciation_of_name) =>
          current_user.pronunciation.attached? ? Pronunciation::Player.new(data: {player_url_value: url_for(current_user.pronunciation)}, class: 'mt-1') : nil
        })
      end
    end
  end
end

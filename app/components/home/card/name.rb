# frozen_string_literal: true

class Components::Home::Card::Name < Components::Base
  def view_template
    render Home::Card.new(title: t('.title'), edit: profile_path(:personal_name), class: 'bg-rose-50 dark:bg-rose-950') do |hc|
      hc.content do
        hc.blurb { t('profile.personal_name.blurb') }
        hc.list(hc.user_attributes_hash(%i[personal_name full_name]), required: true)
      end
    end
  end
end

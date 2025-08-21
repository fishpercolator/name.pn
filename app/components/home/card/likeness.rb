# frozen_string_literal: true

class Components::Home::Card::Likeness < Components::Base
  def view_template
    render Home::Card.new(title: t('.title'), edit: profile_path(:likeness), class: 'bg-likeness') do |hc|
      hc.content do
        hc.blurb { t('profile.likeness.blurb') }
        if current_user.likeness.attached?
          render Components::User::Likeness.new(user: current_user)
        else
          hc.not_set
        end
      end
    end
  end
end

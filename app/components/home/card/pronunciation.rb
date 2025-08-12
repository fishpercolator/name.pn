# frozen_string_literal: true

class Components::Home::Card::Pronunciation < Components::Base
  def view_template
    render Home::Card.new(title: t('.title'), edit: profile_path(:pronunciation), class: 'bg-rose-50 dark:bg-rose-950')
  end
end

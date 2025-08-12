# frozen_string_literal: true

class Components::Home::Card::Links < Components::Base
  def view_template
    render Home::Card.new(title: t('.title'), edit: profile_path(:links), class: 'bg-rose-50 dark:bg-rose-950')
  end
end

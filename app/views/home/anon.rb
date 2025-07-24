# frozen_string_literal: true

class Views::Home::Anon < Views::Base
  def view_template
    div(class: 'flex justify-center') { Home::Logo() }
  end
end

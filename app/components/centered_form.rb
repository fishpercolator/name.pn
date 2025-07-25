# frozen_string_literal: true

class Components::CenteredForm < Components::Base
  def view_template(&)
    div(class: 'grow flex items-center justify-center') do
      div(&)
    end
  end

  def title(&)
    h1(class: 'text-3xl font-bold mb-6', &)
  end

  def main(&)
    Box(&)
  end
end

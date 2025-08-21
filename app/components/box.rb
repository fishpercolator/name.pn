# frozen_string_literal: true

class Components::Box < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    div(**mix({class: 'rounded-xl border bg-background shadow p-4 md:p-6'}, @attributes), &)
  end
end

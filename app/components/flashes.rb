# frozen_string_literal: true

class Components::Flashes < Components::Base
  include Phlex::Rails::Helpers::Flash

  def initialize(class: nil)
    @class = grab(class:)
  end

  def view_template(&)
    if flash[:notice] || flash[:alert]
      div(class: @class) do
        if flash[:notice]
          Alert do
            AlertTitle { flash[:notice] }
          end
        end
        if flash[:alert]
          Alert(variant: :destructive) do
            AlertTitle { flash[:alert] }
          end
        end
      end
    end
  end
end

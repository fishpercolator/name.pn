# frozen_string_literal: true

class Components::Flashes < Components::Base
  include Phlex::Rails::Helpers::Flash

  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    if flash[:notice] || flash[:alert]
      div(**@attributes) do
        if flash[:notice]
          Alert(variant: :success) do
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

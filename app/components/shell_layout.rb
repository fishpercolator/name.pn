# frozen_string_literal: true

class Components::ShellLayout < Components::Layout
  def view_template
    super do
      PageHeader()
      main do
        div(class: container_classes + %w[py-8 lg:py-12]) do
          yield
        end
      end
    end
  end
end

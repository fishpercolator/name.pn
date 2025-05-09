# frozen_string_literal: true

class Components::ShellLayout < Components::Layout
  def view_template
    super do
      PageHeader()
      main do
        div(class: 'px-2 sm:px-4 sm:container py-4 sm:py-8') do
          yield
        end
      end
    end
  end
end

# frozen_string_literal: true

class Components::CenteredForm < Components::Base
  def view_template(&)
    ShellLayout(main_class: 'grow flex flex-col items-center justify-center', flashes_class: 'w-screen max-w-lg mx-3 sm:mx-0 pb-6') do
      div(class: 'w-screen max-w-lg', &)
    end
  end

  def title(&)
    h1(class: 'text-3xl font-bold mx-3 sm:mx-0', &)
  end

  def section(&)
    Box(class: 'mx-3 sm:mx-0 my-6 space-y-4', &)
  end

  def footer(&)
    div(class: 'mx-3 sm:mx-0 my-6 space-y-4', &)
  end
end

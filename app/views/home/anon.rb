# frozen_string_literal: true

class Views::Home::Anon < Views::Base
  def view_template
    Layout(title: "Home") do
      h1 { "This is the homepage" }
      Button { "Hello" }
    end
  end
end

class Views::Home::Offline < Views::Base
  def view_template
    Prose do
      h1 { page_title(t('.title')) }
    end
  end
end

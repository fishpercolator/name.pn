class Views::Home::Offline < Views::Base
  def view_template
    Prose { PageTitle(t('.title')) }
  end
end

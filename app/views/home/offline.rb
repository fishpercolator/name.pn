class Views::Home::Offline < Views::Base
  def view_template
    Container { PageTitle(t('.title')) }
  end
end

class Views::Home::Offline < Views::Base
  def view_template
    div(class: 'container mx-auto px-4 py-12') { PageTitle(t('.title')) }
  end
end

class Views::Home::Offline < Views::Base
  def view_template
    Container do
      PageTitle(t('.title'))
    end
  end
end

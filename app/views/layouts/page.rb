class Views::Layouts::Page < Views::Layouts::Application
  protected

  def page(&) = Prose(&)
end

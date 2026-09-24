class Components::UI::PageTitle < Components::Base
  def view_template(&)
    h1(class: 'page-title text-4xl font-bold', &)
  end
end

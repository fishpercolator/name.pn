class Components::UI::BulletList < Components::Base
  def view_template(&)
    ul(class: 'list-inside list-[square]', &)
  end

  def item(&) = li(&)
end

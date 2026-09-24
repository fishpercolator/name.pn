class Components::UI::BulletList < Components::Base
  def view_template(&)
    ul(class: 'list-outside list-[square]', &)
  end

  def item(&) = li(&)
end

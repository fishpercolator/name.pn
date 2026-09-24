class Components::UI::BulletList < Components::Base
  def view_template(&)
    ul(class: 'list-disc leading-7', &)
  end

  def item(&) = li(&)
end

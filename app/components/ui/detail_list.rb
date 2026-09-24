class Components::UI::DetailList < Components::Base
  def view_template(&)
    dl(class: 'leading-7', &)
  end

  def item(label, &)
    dt(class: 'mt-5 font-bold first:mt-0') { label }
    dd(class: 'mt-1 ms-6', &)
  end
end

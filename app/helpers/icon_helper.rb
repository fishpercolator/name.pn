module IconHelper

  def icon(name, class: 'mdi')
    inline_svg_tag "icons/#{name}.svg", class: binding.local_variable_get(:class)
  end

end

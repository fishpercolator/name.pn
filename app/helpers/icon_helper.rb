module IconHelper

  def icon(name, class: 'mdi size-[1em] fill-current')
    inline_svg_tag "icons/#{name}.svg", class: binding.local_variable_get(:class)
  end

end

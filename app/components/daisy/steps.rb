class Components::Daisy::Steps < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    ul(**mix({ class: 'steps steps-vertical w-full text-sm md:steps-horizontal' }, @attributes), &)
  end

  def step(label, href: nil, done: false)
    li(class: ['step relative text-start md:text-center', ('step-accent' if done)]) do
      href ? a(href:, class: 'link-hover after:absolute after:inset-0 after:z-10') { label } : plain(label)
    end
  end
end

# frozen_string_literal: true

class Components::PageFooter < Components::Base
  # From https://github.com/ruby-ui/web/blob/main/app/components/shared/navbar.rb
  
  def initialize
    @left_links = []
    @right_links = []
  end

  def view_template(&)
    vanish(&)
    footer(class: 'top-0 z-50 w-full border-b bg-background') do
      div(class: 'px-2 sm:px-4 sm:container flex flex-col sm:flex-row sm:h-14 items-center justify-between') do
        div(class: 'mr-4 flex flex-wrap items-center') do
          @left_links.each { render_link(it) }
        end
        div(class: 'flex flex-wrap items-center') do
          @right_links.each { render_link(it) }
        end
      end
    end
  end

  def left_link(href, **args, &content)
    @left_links << {href:, content:, **args}
  end

  def right_link(href, **args, &content)
    @right_links << {href:, content:, **args}
  end

  protected

  def link_class
    nil
  end
  
  def render_link(link)
    Link(**mix(link.except(:content), {variant: :ghost, class: link_class}), &link[:content])
  end
end

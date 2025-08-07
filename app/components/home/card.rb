# frozen_string_literal: true

class Components::Home::Card < Components::Base
  def initialize(title:, edit: nil, **attributes)
    @title = title
    @edit = edit
    @attributes = attributes
  end

  def view_template(&content)
    render RubyUI::Card.new(**@attributes) do
      CardHeader(class: 'flex-row justify-between items-center') do
        CardTitle { @title }
        if @edit.present?
          Link(variant: :outline, icon: true, href: @edit, title: t('.edit')) { icon 'pencil', class: 'p-2 fill-current' }
        end
      end
      content&.call
    end
  end

  def content(&)
    CardContent(&)
  end

  def footer(&)
    CardFooter(&)
  end

  def blurb(**attributes, &)
    Text(**mix({class: 'mb-4 text-muted-foreground'}, attributes), &)
  end

  # Provide a list of key/value pairs to render as a dl. If value is a list, it
  # will be rendered as a ul within the dl
  def list(pairs, **attributes)
    dl(**attributes) do
      pairs.each do |k,v|
        dt(class: "font-semibold after:content-[':']") { k }
        dd(class: 'ms-6') do
          case v
          when nil, ''
            em(class: 'text-muted-foreground font-italic') { t('.not_set') }
          when Array
            ul(class: 'list-disc') do
              v.each {|name| li { name }}
            end
          else
            v
          end
        end
      end
    end
  end

end

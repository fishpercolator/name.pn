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
        CardTitle(class: 'm-0') { @title }
        Link(variant: :outline, icon: true, href: @edit, title: t('.edit')) { icon 'pencil', class: 'p-2 fill-current' } if @edit.present?
      end
      content&.call
    end
  end

  def content(&)
    CardContent(&)
  end

  def footer(&)
    CardFooter(class: 'flex gap-2 pt-6', &)
  end

  def footer_button(component=RubyUI::Link, **attributes, &)
    render component.new(**mix({class: 'grow basis-0 bg-background cursor-pointer h-auto p-3', variant: :ghost}, attributes), &)
  end

  def blurb(**attributes, &)
    Text(**mix({class: 'mb-4 text-muted-foreground'}, attributes), &)
  end

  # Provide a list of key/value pairs to render as a dl. 
  def list(pairs, required: false, **attributes)
    dl(**attributes) do
      pairs.each do |k,v|
        dt(class: "font-semibold after:content-[':']") { k }
        dd(class: 'ms-6') { list_value v, required: }
      end
    end
  end

  # If value is a list, it will be rendered as a ul
  def list_value(v, required: false)
    case v
    when nil, ''
      required ? you_must : not_set
    when Array
      ul(class: 'list-disc') do
        v.each {|name| li { name }}
      end
    when Phlex::HTML
      render v
    else
      v
    end
  end

  def not_set
    em(class: 'text-muted-foreground font-italic') { t('.not_set') }
  end

  def you_must
    strong(class: 'font-semibold text-destructive-foreground') { t('.you_must') }
  end

  # Convert a list of attribute names to a hash of human name to value
  def user_attributes_hash(attributes)
    attributes.to_h { [
      ::User.human_attribute_name(_1), 
      current_user.public_send(_1),
    ] }
  end


end

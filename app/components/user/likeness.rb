# frozen_string_literal: true

class Components::User::Likeness < Components::Base
  attr_reader :user, :attributes

  def initialize(user:, **attributes)
    @user = user
    @attributes = attributes
  end

  def view_template
    a(**mix({
        href: url_for(user.likeness), 
        data: {controller: 'lightbox'}, 
        title: t('.expand'),
        class: 'cursor-zoom-in'
      }, attributes)
    ) do
      image_tag user.likeness.variant(resize_to_limit: [300, 300]), 
        alt: t('.alt', name: user.full_name), 
        class: 'rounded-full'
    end
  end
end

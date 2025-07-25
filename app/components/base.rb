# frozen_string_literal: true

class Components::Base < Phlex::HTML
  extend Literal::Properties
  include Components
  include RubyUI

  # Include any helpers you want to be available across all components
  include Phlex::Rails::Helpers::ImageTag
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::T

  register_output_helper :icon
  register_output_helper :inline_svg_tag

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end

  def container_classes
    %w[mx-auto max-w-screen-xl px-4 sm:px-6 lg:px-8]
  end

end

ApplicationComponent = Components::Base

# frozen_string_literal: true

class Views::Devise::Base < Views::Base
  include Phlex::Rails::Helpers::FormFor

  attr_reader :resource, :resource_name

  def initialize(resource:, resource_name:)
    @resource = resource
    @resource_name = resource_name
  end
end
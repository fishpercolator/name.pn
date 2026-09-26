class Views::Base < Components::Base
  include Phlexible::Rails::ControllerVariables

  def self.translation_path = @translation_path ||= super.delete_prefix('views.')

  def cache_store = Rails.cache
end

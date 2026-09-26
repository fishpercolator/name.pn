class Views::Base < Components::Base
  register_value_helper :set_meta_tags

  def self.translation_path = @translation_path ||= super.delete_prefix('views.')

  def cache_store = Rails.cache

  private

  def page_title(text)
    set_meta_tags(title: text)
    text
  end
end

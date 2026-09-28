module ErrorPages
  PRODUCTION_SETTINGS = {
    'action_dispatch.show_exceptions' => :all,
    'action_dispatch.show_detailed_exceptions' => false
  }.freeze

  class << self
    def render_like_production
      @test_settings = env_config.slice(*PRODUCTION_SETTINGS.keys)
      env_config.merge!(PRODUCTION_SETTINGS)
    end

    def restore
      env_config.merge!(@test_settings) if @test_settings
    end

    private

    def env_config = Rails.application.env_config
  end
end

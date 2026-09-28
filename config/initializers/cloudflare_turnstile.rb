RailsCloudflareTurnstile.configure do |config|
  config.size = :flexible

  case Rails.env
  when "production"
    config.site_key = ENV.fetch("TURNSTILE_SITE_KEY")
    config.secret_key = ENV.fetch("TURNSTILE_SECRET_KEY")
  when "development"
    # Cloudflare's always-pass keys: https://developers.cloudflare.com/turnstile/troubleshooting/testing/
    config.site_key = "1x00000000000000000000AA"
    config.secret_key = "1x0000000000000000000000000000000AA"
  else
    config.enabled = false
    config.mock_enabled = false
  end
end

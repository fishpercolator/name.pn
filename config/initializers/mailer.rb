if ActionMailer::Base.default_url_options&.dig(:host).blank?
  ActionMailer::Base.default_url_options = {
    host: ENV['DOMAIN_IN_EMAIL_LINKS'] || ENV['DOMAIN_NAME'] || 'changeme.example.com',
    protocol: 'https'
  }
end

ActionMailer::Base.default_options = {
  from: ENV['EMAIL_FROM'] || 'changeme@example.com'
}

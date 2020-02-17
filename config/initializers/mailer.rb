ActionMailer::Base.default_url_options = {
  host: ENV['DOMAIN_IN_EMAIL_LINKS'] || ENV['DOMAIN_NAME'] || 'changeme.example.com',
  protocol: 'https'
}
ActionMailer::Base.default_options = {
  from: ENV['EMAIL_FROM'] || 'changeme@example.com'
}
# Make sure the Devise Mailer uses the email layout too
Devise::Mailer.layout('mailer')

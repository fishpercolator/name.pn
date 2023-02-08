service_name = 'name-pn'
Datadog.configure do |c|
  c.tracing.enabled = Figaro.env.dd_api_key?
  c.service = service_name
  c.tracing.instrument :rails
end
SemanticLogger.application = service_name

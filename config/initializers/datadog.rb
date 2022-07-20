service_name = 'name-pn'
Datadog.configure do |c|
  c.service = service_name
  c.tracing.instrument :rails
end
SemanticLogger.application = service_name

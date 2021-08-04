service_name = 'name-pn'
Datadog.configure do |c|
  c.use :rails, log_injection: true, service_name: service_name
end
SemanticLogger.application = service_name

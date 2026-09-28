Rails.application.config.exceptions_app = lambda do |env|
  errors = env['action_dispatch.original_path'].start_with?('/api/') ? Api::ErrorsController : ErrorsController
  errors.action(:show).call(env)
end

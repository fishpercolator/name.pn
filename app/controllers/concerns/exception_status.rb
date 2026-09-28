# For controllers serving config.exceptions_app, which ShowExceptions calls
# with the path rewritten to the status code, e.g. /404
module ExceptionStatus
  private

  def status_code = request.path_info.delete_prefix("/").to_i

  def status_name = Rack::Utils::SYMBOL_TO_STATUS_CODE.key(status_code) || :internal_server_error
end

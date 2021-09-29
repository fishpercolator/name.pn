Gaffe.configure do |config|
  config.errors_controller = {
    %r{\A/api/} => 'Api::ErrorsController',
    %r{\A/} => 'ErrorsController'
  }
end

Gaffe.enable!

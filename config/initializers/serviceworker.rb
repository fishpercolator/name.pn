Rails.application.configure do
  config.serviceworker.routes.draw do
    get "/serviceworker.js"
  end
end

require 'httparty'
require 'addressable'

class Buttondown
  include HTTParty
  base_uri 'https://api.buttondown.email'

  def initialize(key)
    self.class.headers 'Authorization' => "Token #{key}"
  end

  def subscribed?(email)
    subscriber(email)&.dig('subscriber_type') == 'regular'
  end

  def unsubscribe!(email)
    if s = subscriber(email)
      self.class.delete(subscriber_url(s["email"]))
    end
  end

  def subscribe!(email, metadata={})
    if s = subscriber(email)
      self.class.patch(subscriber_url(s["email"]), body: {subscriber_type: 'regular', metadata: metadata}.to_json)
    else
      self.class.post("/v1/subscribers", body: {email: email, subscriber_type: 'regular', metadata: metadata}.to_json)
    end
  end

  private

  def subscriber(email)
    self.class.get(subscriber_url email)
  end

  def subscriber_url(email)
    Addressable::Template.new("/v1/subscribers/{email}").expand(email: email)
  end

end

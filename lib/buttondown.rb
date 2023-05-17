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
      self.class.delete(subscriber_url(s))
    end
  end

  def subscribe!(email, metadata={})
    if s = subscriber(email)
      self.class.patch(subscriber_url(s), body: {subscriber_type: 'regular', metadata: metadata}.to_json)
    else
      self.class.post("/v1/subscribers", body: {email: email, subscriber_type: 'regular', metadata: metadata}.to_json)
    end
  end

  private

  def subscribers(params)
    self.class.get("/v1/subscribers", {query: params})['results']
  end

  def subscriber(email)
    # Filter the results because the current API call matches substrings
    subscribers(email: email).find {|s| s['email'] == email}
  end

  def subscriber_url(subscriber)
    Addressable::Template.new("/v1/subscribers/{id}").expand(id: subscriber['id'])
  end

end

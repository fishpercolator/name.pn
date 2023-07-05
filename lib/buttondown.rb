require 'faraday'
require 'addressable'

class Buttondown

  attr_reader :conn, :key

  def initialize(key)
    @key = key
    @conn = Faraday.new(url: 'https://api.buttondown.email') do |f|
      f.request :authorization, 'Token', key
      f.request :json
      f.response :json
      f.response :raise_error
    end
  end

  # Note: Assumes all subscribers are 'regular' and not 'premium' and other paid subscription
  # statuses
  def subscribed?(email)
    subscriber(email)&.dig('subscriber_type') == 'regular'
  end

  def unsubscribe!(email)
    if s = subscriber(email)
      conn.delete(subscriber_url(s["id"]))
    end
  end

  def subscribe!(email, metadata={})
    if s = subscriber(email)
      conn.patch(subscriber_url(s["id"]), {subscriber_type: 'regular', metadata: metadata})
    else
      conn.post("/v1/subscribers", {email: email, subscriber_type: 'regular', metadata: metadata})
    end
  end

  def inspect
    "#<Buttondown key=#{key.inspect}>"
  end

  private

  def subscriber(id_or_email)
    conn.get(subscriber_url id_or_email).body
  rescue Faraday::ResourceNotFound
    nil # return nil if there is a 404 and raise all other kinds of exceptions
  end

  def subscriber_url(id_or_email)
    Addressable::Template.new("/v1/subscribers/{id}").expand(id: id_or_email)
  end

end

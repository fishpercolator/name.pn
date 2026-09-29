# Stands in for Buttondown, keeping its subscribers in memory
class MockButtondown
  attr_reader :subscribers

  def initialize(subscribers = {})
    @subscribers = subscribers
  end

  def subscribed?(email) = subscribers.key?(email)

  def subscribe!(email, metadata = {})
    metadata = metadata.dup
    subscribers.delete(metadata.delete(:email_was) || email)
    subscribers[email] = metadata
  end

  def unsubscribe!(email) = subscribers.delete(email)
end

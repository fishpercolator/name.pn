FactoryBot.define do
  factory :link do
    user
    title { "Twitter" }
    url { "https://twitter.com/fishpercolator" }
  end
end

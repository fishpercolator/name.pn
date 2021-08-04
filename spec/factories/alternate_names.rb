FactoryBot.define do
  factory :alternate_name do
    user
    name { "Philip Gerard" }
    category { :variant }
  end
end

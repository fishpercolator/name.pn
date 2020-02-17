FactoryBot.define do
  sequence(:email) {|n| "email#{n}@example.com" }
  factory :user do
    email { generate :email }
    password { "letmein123" }
    trait :test do
      email { 'testuser@example.com' }
    end
  end
end

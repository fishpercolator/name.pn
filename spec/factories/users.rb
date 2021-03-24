FactoryBot.define do
  sequence(:email) {|n| "email#{n}@example.com" }
  factory :user do
    email { generate :email }
    password { "letmein123" }
    trait :test do
      email { 'testuser@example.com' }
    end
    trait :basic_profile do
      full_name { 'Audrey Horne' }
      personal_name { 'Audrey' }
      pronoun_sets { [create(:pronoun_set, :she)] }
    end
    trait :full_profile do
      basic_profile
      formal_name { 'Ms Horne' }
      envelope_name { 'Ms A. H. Horne' }
      phonetic { 'AWD-ree HORN' }
      pronunciation { fixture_file_upload(file_fixture 'pronunciation.wav') }
      likeness { fixture_file_upload(file_fixture 'likeness.png') }
    end
  end
end

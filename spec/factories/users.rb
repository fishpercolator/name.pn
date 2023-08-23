FactoryBot.define do
  sequence(:email) {|n| "email#{n}@example.com" }
  factory :user do
    email { generate :email }
    password { "letmein123" }
    terms { true }
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
      email_name { 'Audrey' }
      envelope_name { 'Ms A. H. Horne' }
      phonetic { 'AWD-ree HORN' }
      ipa { 'ˈɔːdri hɔːn' }
      pronunciation { fixture_file_upload(file_fixture('pronunciation.wav'), 'audio/wav') }
      likeness { fixture_file_upload(file_fixture('likeness.png'), 'image/png') }
      links { [
        build(:link, title: 'Twitter', url: 'https://twitter.com/ahorne'),
        build(:link, title: 'LinkedIn', url: 'https://linkedin.com/in/ahorne')
      ] }
      alternate_names { [
        build(:alternate_name, name: 'Hester Prynne', category: :like),
        build(:alternate_name, name: 'Scarlett', category: :like),
        build(:alternate_name, name: 'Aud', category: :dislike)
      ] }
    end
  end
end

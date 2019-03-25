FactoryBot.define do
  factory :user do
    association :role
    sequence(:username) { |n| "harshita#{n}" }
    sequence(:email) { |n| "hars#{n}@gmail.com" }
    sequence(:password) { |n| "hasrhita#{n}"}

    trait :with_avatar do
      after :create do |user|
        file_path = Rails.root.join('spec', 'assets', 'pm.png')
        file = fixture_file_upload(file_path, 'image/png')
        user.avatar.attach(file)
      end
    end
  end
end

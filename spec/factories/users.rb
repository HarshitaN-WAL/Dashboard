FactoryBot.define do
  factory :user do
    association :role
    username { 'harshita' }
    email { 'hars@gmail.com' }
    password { 'hasrhita' }

    trait :with_avatar do
      after :create do |user|
        file_path = Rails.root.join('spec', 'assets', 'pm.png')
        file = fixture_file_upload(file_path, 'image/png')
        user.avatar.attach(file)
      end
    end
  end
end

FactoryBot.define do
  factory :user do
    username {"harshita"}
    email {"hars@gmail.com"}
    password {"hasrhita"}
    role_id {4}
    
    association :role
  end
end

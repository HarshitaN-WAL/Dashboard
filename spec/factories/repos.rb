FactoryBot.define do
  factory :repo do
    sequence(:link) {|n| "https://github.com/#{n}"}
  end
end

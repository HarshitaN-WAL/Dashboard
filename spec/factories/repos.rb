FactoryBot.define do
  factory :repo do
    sequence(:link) {|n| "https://github.com/#{1}"}
  end
end

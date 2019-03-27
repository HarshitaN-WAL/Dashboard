# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    sequence(:rolename) {|n| "Role#{n}"}
    # rolename { %w[Developer Manager Tester].sample }
  end
end

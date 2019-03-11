# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    rolename { %w[Developer Manager Tester].sample }
  end
end

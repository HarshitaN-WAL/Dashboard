# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    association :project_users
    name {'monster'}
    start_date {'2019-02-25'}
    expected_target_date {'2019-03-25'}
    project_token {'2199776'}
    pt_token {'db582a94d248f6b17143351774a0000'}

  end
end

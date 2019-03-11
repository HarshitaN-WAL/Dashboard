# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name {'monster'}
    start_date {'2019-02-25'}
    expected_target_date {'2019-03-25'}
    project_token {'2199776'}
    pt_token {'db582a94d248f6b17143351774a0000'}
    quality_token {'4a6076ef74c16d09d7cca6dbab264d89dc015eee'}
    github_slug {'HarshitaN-WAL/Dashboard'}
  end
end

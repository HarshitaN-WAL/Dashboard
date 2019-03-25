# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    association :repos, factory: :repo
    sequence(:name) { |n| "project#{n}@example.com" }
    start_date {1.week.ago}
    expected_target_date {Time.now}
    project_token {'2229070'}
    pt_token {'c375f55b052a451a29db1e42eb2b0232'}
    quality_token {'4a6076ef74c16d09d7cca6dbab264d89dc015eee'}
    sequence(:github_slug) { |n| "abcdefg#{n}/qwttd" }
    sequence(:client) { |n| "abcd#{n}"}
    # after(:create) do |project|
    #     project.repos.create(:repo)
    #     # project.repos.create(attributes_for(:repos))
    # end
    # after(:build) do |project|
    #     project.repos.create(:repo)
    #     # project.repos.create(attributes_for(:repos))
    # end

    # repos {|repos| [repos.association(:repo)]}
  end

  
end

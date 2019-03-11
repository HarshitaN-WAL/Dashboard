# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-status'
require 'sidekiq/web'

sidekiq_config = if (Rails.env.development? || Rails.env.test?) && ENV['CIRCLE_CI'].nil?
                   { url: 'redis://localhost:6379/0' }
                 elsif ENV['CIRCLE_CI'] == 'circleci'
                   { url: 'redis://localhost:6379/0' }
                 else
                   { url: "redis://#{Rails.application.credentials[:redis_url]}" }
         end
Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes
  end
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes
  end
end

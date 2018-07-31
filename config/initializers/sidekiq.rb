Rails.logger.info "=-=-=-= Sidekiq Initializer =-=-=-="

Sidekiq.configure_client do |config|
  Rails.logger.info "=-=-=-= Sidekiq.configure_client =-=-=-="
  Rails.logger.info "redis://#{ENV['REDIS_URL']}:#{ENV['REDIS_PORT']}/0"
  config.redis = { url: "redis://#{ENV['REDIS_URL']}:#{ENV['REDIS_PORT']}/0"}
end

Sidekiq.configure_server do |config|
  Rails.logger.info "=-=-=-= Sidekiq.configure_server =-=-=-="
  Rails.logger.info "redis://#{ENV['REDIS_URL']}:#{ENV['REDIS_PORT']}/0"
  config.redis = { url: "redis://#{ENV['REDIS_URL']}:#{ENV['REDIS_PORT']}/0"}
end

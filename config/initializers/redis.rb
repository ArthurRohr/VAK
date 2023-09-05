require "redis"

$redis = Redis.new(password: ENV["REDIS_PASSWORD"])
url = ENV["REDISCLOUD_URL"]

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
  $redis = Redis.new(url: url, password: ENV["REDIS_PASSWORD"])
end

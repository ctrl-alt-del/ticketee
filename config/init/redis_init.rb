# Start redis instance in the background for different environment
require "redis"

redis_conf_path = "#{::Rails.root}/config/redis/#{::Rails.env}.conf"
redis_conf = File.read(redis_conf_path)
port = /^port.(\d+)$/.match(redis_conf)[1]

# Check if redis instance has already started
res = `ps aux | grep redis-server`
if res.include?("redis-server") && res.include?(redis_conf_path)
puts "Redis instance has already started in #{::Rails.env} on #{port}"
else
`redis-server "#{redis_conf_path}"`
res = `ps aux | grep redis-server`
if res.include?("redis-server") && res.include?(redis_conf_path)
puts "Starting redis instance in #{::Rails.env} on #{port}"
else
raise "Couldn't start redis"
end
end

REDIS = Redis.new(:port => port)
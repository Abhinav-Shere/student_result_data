schedule_file = Rails.root.join('config', 'schedule.yml')

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq::Cron::Job.load_from_hash( YAML.load_file(schedule_file))
  end
end

Sidekiq.configure_client do |config|
  config.redis = { size: 1 }
end

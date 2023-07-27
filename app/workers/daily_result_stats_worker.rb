class DailyResultStatsWorker
  include Sidekiq::Worker

  def perform(*args)
    DailyResultStatsController.new.create
  end
end

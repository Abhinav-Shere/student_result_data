class DailyResultStatsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    daily_result = DailyResultStatsController.new
    daily_result.create
  end
end

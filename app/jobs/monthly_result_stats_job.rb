class MonthlyResultStatsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    monthly_average = MonthlyAveragesController.new
    monthly_average.create
  end
end
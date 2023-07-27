class MonthlyResultStatsWorker
  include Sidekiq::Worker

  def perform(*args)
    MonthlyAveragesController.new.create
  end
end
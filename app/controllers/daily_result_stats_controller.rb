class DailyResultStatsController < ApplicationController
  def create
    subjects = ResultDatum.distinct.pluck(:subject)

    subjects.each do |subject|
      daily_result_processing_service = DailyResultProcessingService.new(subject)
      daily_result_processing_service.process_and_save_stats
    end
  end

  def index
    @daily_stat = DailyResultStat.all
    render json: @daily_stat
  end
end



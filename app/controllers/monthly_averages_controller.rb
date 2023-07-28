class MonthlyAveragesController < ApplicationController
  def create
    subjects = ResultDatum.distinct.pluck(:subject)

    subjects.each do |subject|
      daily_result_processing_service = MonthlyResultProcessingService.new(subject)
      daily_result_processing_service.process_and_save_stats
    end
  end

  def index
    @monthly_data = MonthlyAverage.all
    render json: @monthly_data
  end
end

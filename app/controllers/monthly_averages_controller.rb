class MonthlyAveragesController < ApplicationController
  def create
    result = Benchmark.measure do
      subjects = ResultDatum.distinct.pluck(:subject)

      subjects.each do |subject|
        daily_result_processing_service = MonthlyResultProcessingService.new(subject)
        daily_result_processing_service.process_and_save_stats
      end
    end
    
    puts "Execution time for create action: #{result.total} seconds"
  end

  def index
    @monthly_data = MonthlyAverage.all
    render json: @monthly_data
  end
end

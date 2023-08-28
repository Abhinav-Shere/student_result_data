class DailyResultStatsController < ApplicationController
  def create
    result = Benchmark.measure do
      subjects = ResultDatum.distinct.pluck(:subject)

      subjects.each do |subject|
        DailyResultProcessingService.new(subject)
                                    .process_and_save_stats
      end
    end

    render json: { message: "DailyResultStat create" }
    puts "Execution time for create action: #{result.total} seconds"
  end

  def index
    @daily_stat = DailyResultStat.all
    @daily_stat = @daily_stat.where(date: params[:day]) if params[:day].present?
    render json: @daily_stat
  end
end



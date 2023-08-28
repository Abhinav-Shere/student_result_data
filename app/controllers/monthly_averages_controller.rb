class MonthlyAveragesController < ApplicationController
  def create
    result = Benchmark.measure do
      subjects = ResultDatum.distinct.pluck(:subject)

      subjects.each do |subject|
        MonthlyResultProcessingService.new(subject)
                                      .process_and_save_stats
      end
    end
    
    render json: { message: "MonthlyAverage create" }
    puts "Execution time for create action: #{result.total} seconds"
  end

  def index
    day = params[:day].to_date
    given_day = day
    count = 0
    result = []
    loop do
      result = DailyResultStat.where('date <= ? AND date >= ?', day, day - 5.days)
      count = result.count
      if count > 1
        break
      elsif day < (given_day - 1.month)
        result = []
        break
      else
        day = day - 5.days
      end
    end

    unless result.instance_of?(Array)
      final_result = []
      debugger
      result.group_by{ |e| [e.date, e.subject] }.each do |key, data|
        final_result << {
          date: key[0],
          subject: key[1],
          daily_low: data.map(&:daily_low).sum / data.count,
          daily_high: data.map(&:daily_high).sum / data.count,
          daily_volume: data.count
        }
      end
      result = final_result
    end

    render json: result    
  end
end

class DailyResultStatsController < ApplicationController
	def create
    begin
      subjects = ResultDatum.distinct.pluck(:subject)

      subjects.each do |subject|
        result_data_per_day = ResultDatum.where(subject: subject).group_by { |data| data.timestamp.to_date }

        result_data_per_day.each do |date, data|
          daily_low = data.min_by(&:marks).marks
          daily_high = data.max_by(&:marks).marks
          result_count = data.size
          
          DailyResultStat.create!(
            date: date,
            subject: subject,
            daily_low: daily_low,
            daily_high: daily_high,
            result_count: result_count
          )
        end
      end
    end
  end

  def index
    begin
      @daily_stat = DailyResultStat.all
      render json: @daily_stat
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :unprocessable_entity
    end
  end
end

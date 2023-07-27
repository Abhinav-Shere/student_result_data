class MonthlyAveragesController < ApplicationController
	def create
    begin
      subjects = ResultDatum.distinct.pluck(:subject)

      subjects.each do |subject|
        result_data_per_month = ResultDatum.where(subject: subject).group_by { |data| data.timestamp.beginning_of_month }

        result_data_per_month.each do |month, data|
          monthly_avg_low = data.map(&:marks).sum / data.size
          monthly_avg_high = data.map(&:marks).max
          result_count_used = data.size

          MonthlyAverage.create!(
            date: month,
            subject: subject,
            monthly_avg_low: monthly_avg_low,
            monthly_avg_high: monthly_avg_high,
            monthly_result_count_used: result_count_used
          )
        end
      end
    end
  end

  def index
    begin
      @monthly_data = MonthlyAverage.all
      render json: @monthly_data
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :unprocessable_entity
    end
  end
end

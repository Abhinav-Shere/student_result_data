class MonthlyResultProcessingService
  def initialize(subject)
    @subject = subject
  end

  def process_and_save_stats
    result_data_per_month = ResultDatum.group_by_date_and_subject(@subject)
    
    result_data_per_month.each do |month, data|
      monthly_avg_low = data.map(&:marks).sum / data.size
      monthly_avg_high = data.map(&:marks).max
      result_count_used = data.size

      MonthlyAverage.find_or_create_by(
        date: month,
        subject: @subject
      ) do |record|
        record.monthly_avg_low = monthly_avg_low
        record.monthly_avg_high = monthly_avg_high
        record.monthly_result_count_used = result_count_used
      end
    end
  end
end
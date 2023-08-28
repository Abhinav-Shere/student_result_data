class DailyResultProcessingService
  def initialize(subject)
    @subject = subject
  end

  def process_and_save_stats
    result_data_per_day = ResultDatum.group_by_date_and_subject(@subject)

    result_data_per_day.each do |date, data|
      DailyResultStat.find_or_create_by(date: date, subject: @subject) do |record|
        record.daily_low = data.min_by(&:marks).marks
        record.daily_high = data.max_by(&:marks).marks
        record.result_count = data.size
      end
    end
  end
end
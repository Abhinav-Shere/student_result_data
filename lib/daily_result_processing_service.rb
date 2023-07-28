class DailyResultProcessingService
  def initialize(subject)
    @subject = subject
  end

  def process_and_save_stats
    result_data_per_day = ResultDatum.group_by_date_and_subject(@subject)

    result_data_per_day.each do |date, data|
      daily_low = data.min_by(&:marks).marks
      daily_high = data.max_by(&:marks).marks
      result_count = data.size

      existing_record = DailyResultStat.find_by(date: date, subject: @subject)

      DailyResultStat.find_or_create_by(date: date, subject: @subject) do |record|
        record.daily_low = daily_low
        record.daily_high = daily_high
        record.result_count = result_count
      end
    end
  end
end
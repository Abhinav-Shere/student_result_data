class ResultDatum < ApplicationRecord

  scope :group_by_date_and_subject, ->(subject) {
    where(subject: subject).group_by { |data| data.timestamp.to_date }
  }

  def self.max_marks_data
    order(marks: :desc).first
  end

  def self.min_marks_data
    order(marks: :asc).first
  end
end
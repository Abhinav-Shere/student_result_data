class ResultDatum < ApplicationRecord
  def self.max_marks_data
    order(marks: :desc).first
  end

  def self.min_marks_data
    order(marks: :asc).first
  end
end
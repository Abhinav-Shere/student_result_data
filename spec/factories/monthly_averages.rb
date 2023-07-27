FactoryBot.define do
  factory :monthly_average do
    date { Date.today.beginning_of_month }
    subject { 'Math' }
    monthly_avg_low { 0.0 }
    monthly_avg_high { 100.0 }
    monthly_result_count_used { 0 }
  end
end

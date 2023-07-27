FactoryBot.define do
  factory :daily_result_stat do
    date { Date.today }
    subject { 'Math' }
    daily_low { 0 }
    daily_high { 100 }
    result_count { 0 }
  end
end
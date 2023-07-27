FactoryBot.define do
  factory :result_datum do
    subject { 'Math' }
    timestamp { Time.now }
    marks { 90.0 }
  end
end

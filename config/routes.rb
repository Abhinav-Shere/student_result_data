Rails.application.routes.draw do
  resources :result_datas
  resources :daily_result_stats
  resources :monthly_averages
end

require "sidekiq/web"
Sidekiq::Web.app_url = "/"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"  
  resources :result_datas
  resources :daily_result_stats
  resources :monthly_averages
end

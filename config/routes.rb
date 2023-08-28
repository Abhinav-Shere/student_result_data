require "sidekiq/web"
Sidekiq::Web.app_url = "/"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"  
  post :results_data, to: 'result_datas#results_data'

  resources :result_datas, only: [:create, :index]
  resources :daily_result_stats, only: [:create, :index]
  resources :monthly_averages, only: [:create, :index]
end

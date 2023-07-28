require "sidekiq/web"
Sidekiq::Web.app_url = "/"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"  
  resources :result_datas, only: [:create, :index]
  resources :daily_result_stats, only: [:create, :index]
  resources :monthly_averages, only: [:create, :index]
end

require 'rails_helper'

RSpec.describe MonthlyAveragesController, type: :controller do
  describe 'POST #create' do
    it 'calculates and stores monthly averages' do
      create_list(:result_datum, 3, subject: 'Math', marks: 90.0)
      post :create
      expect(MonthlyAverage.count).to eq(ResultDatum.distinct.count(:subject))
    end
  end

  describe 'GET #index' do
    it 'returns all monthly average data' do
      create_list(:monthly_average, 3)
      get :index
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(3)
    end
  end
end

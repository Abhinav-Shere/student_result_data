require 'rails_helper'

RSpec.describe DailyResultStatsController, type: :controller do
  describe 'POST #create' do
    it 'creates daily result stats' do
      result_datum = create(:result_datum, subject: 'Math', marks: 90)
      post :create
      expect(DailyResultStat.count).to eq(ResultDatum.distinct.count(:subject))
      expect(response).to have_http_status(204)
    end
  end

  describe 'GET #index' do
    it 'returns all daily result stats' do
      create_list(:daily_result_stat, 3)
      get :index
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(3)
    end

    it 'returns empty array if no daily result stats' do
      get :index
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response).to eq([])
    end
  end
end
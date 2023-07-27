require 'rails_helper'

RSpec.describe ResultDatasController, type: :controller do
  describe 'POST #create' do
    it 'creates ResultDatum records from JSON data' do
      post :create
      expect(response).to have_http_status(200)
      expect(ResultDatum.count).to eq(DummyData.json_data.size)
    end
  end

  describe 'GET #index' do
    it 'returns all ResultDatum data' do
      create_list(:result_datum, 3)
      get :index
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(3)
    end
  end
end

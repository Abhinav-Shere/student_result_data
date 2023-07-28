require 'dummy_data'

class ResultDatasController < ApplicationController
  def create
    json_data = DummyData.json_data

    json_data.each do |data|
      result_datum = ResultDatum.create!(
        subject: data[:subject],
        timestamp: data[:timestamp]
      )
      result_datum.update!(marks: data[:marks])
    end

    render json: { message: "ResultData create" }
  end

  def index
    @json_data = ResultDatum.all
    render json: @json_data
  end
end

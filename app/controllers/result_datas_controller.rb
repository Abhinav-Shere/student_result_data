require 'dummy_data'

class ResultDatasController < ApplicationController
  def create
    begin
      json_data = DummyData.json_data

      json_data.each do |data|
        result_datum = ResultDatum.create!(
          subject: data[:subject],
          timestamp: data[:timestamp]
        )

        result_datum.update!(marks: data[:marks])
      end

      render json: { message: "ResultData create" }
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :unprocessable_entity
    end
  end

  def index
    begin
      @json_data = ResultDatum.all
      render json: @json_data
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :unprocessable_entity
    end
  end
end

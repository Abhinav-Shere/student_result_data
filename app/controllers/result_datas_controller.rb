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

  def results_data
    result_datum = ResultDatum.new(
      subject: params[:subject],
      timestamp: params[:timestamp],
      marks: params[:marks]
    )

    if result_datum.save
      render json: { message: "Results Data create" }
    else
      render json: { message: result_datum.errors.full_messages.to_sentence }
    end
  end

  def index
    @json_data = ResultDatum.all
    render json: @json_data
  end
end

class ResultsController < ApplicationController
  def show
    @result = Result.find(params[:id])
    @saunas = Sauna.where(sauna_type_id: @result.sauna_type_id)
  end
end

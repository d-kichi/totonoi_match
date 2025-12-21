class SaunaTypesController < ApplicationController
  def show
    @sauna_type = SaunaType.find(params[:id])
  end
end

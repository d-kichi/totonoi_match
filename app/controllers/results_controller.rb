class ResultsController < ApplicationController
  def show
    @result = Result.find(params[:id])
    @saunas = Sauna.where(sauna_type_id: @result.sauna_type_id)
    @favorite_sauna_ids =
    user_signed_in? ? current_user.favorites.pluck(:sauna_id).to_set : Set.new
  end
end

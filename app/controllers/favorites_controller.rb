class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sauna

  def create
    current_user.favorites.find_or_create_by!(sauna: @sauna)
    redirect_back fallback_location: sauna_path(@sauna), notice: "お気に入りに追加しました"
  end

  def destroy
    current_user.favorites.where(sauna: @sauna).destroy_all
    redirect_back fallback_location: sauna_path(@sauna), notice: "お気に入りを解除しました"
  end

  private

  def set_sauna
    @sauna = Sauna.find(params[:sauna_id])
  end
end

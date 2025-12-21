class SaunasController < ApplicationController
  def index
    @saunas = Sauna.order(created_at: :desc)
  end

  def show
    @sauna = Sauna.find(params[:id])
    @reviews = @sauna.reviews.includes(:user).order(created_at: :desc)
    @review = Review.new
  end
end

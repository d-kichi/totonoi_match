class SaunasController < ApplicationController
  def show
    @sauna = Sauna.find(params[:id])
    @reviews = @sauna.reviews.includes(:user).order(created_at: :desc)
    @review = Review.new
  end
end

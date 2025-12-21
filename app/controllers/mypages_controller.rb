class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @favorite_saunas = current_user.favorite_saunas.order(created_at: :desc)
    @reviews = @user.reviews.includes(:sauna).order(created_at: :desc)
  end
end
